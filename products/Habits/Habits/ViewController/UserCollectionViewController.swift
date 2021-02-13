//
//  UserCollectionViewController.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-10.
//

import UIKit


// MARK: - Define Model and Model View
class UserCollectionViewController: UICollectionViewController {
  
  typealias DataSourceType =
    UICollectionViewDiffableDataSource<ViewModel.Section, ViewModel.Item>
  
  enum ViewModel {
    typealias Section = Int
    
    struct Item: Hashable {
      let user: User
      let isFollowed: Bool
    }
  }
  
  struct Model {
    var usersByID = [String:User]()
    var followedUsers: [User] {
      return Array(usersByID.filter { Settings.shared.followedUserIDs.contains($0.key)}.values)
    }
  }
  
  var dataSource: DataSourceType!
  var model = Model()
  
}


// MARK: - Config View load
extension UserCollectionViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .systemGreen
    
    // Register cell classes
    self.collectionView!.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: PrimarySecondaryTextCollectionViewCell.UserReusableIdentifier)
    
    dataSource = createDataSource()
    collectionView.dataSource = dataSource
    collectionView.collectionViewLayout = createLayout()
    
    update()
  }
}


// MARK: - Create Snapshot and apply to Data source form model
extension UserCollectionViewController {
  /// Using model, create snapshot and apply to data source. This time, section is only one.
  func updateCollectionView(){
    
    // create users data from model. (wrapping by ViewModel and attached isFollowed)
    let users = model.usersByID.values.sorted().reduce(into: [ViewModel.Item]()){ partial, user in
      partial.append(ViewModel.Item(user: user, isFollowed: model.followedUsers.contains(user)))
    }
    
    let itemsBySection = [0: users]
    
    dataSource.applySnapshotUsing(sectionIDs: [0], itemsBySection: itemsBySection)
  }
  
  func createDataSource() -> DataSourceType {
    
    let dataSource = DataSourceType(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionViewCell.UserReusableIdentifier, for: indexPath) as! UserCollectionViewCell
      
      cell.primaryTextLabel.text = item.user.name
      return cell
    })
    
    return dataSource
  }
  
  func createLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.45))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
    group.interItemSpacing = .fixed(20)
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 20
    section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    
    return UICollectionViewCompositionalLayout(section: section)
  }
}

// MARK: - Fetch and update model
extension UserCollectionViewController {
  /// fetch user dat from server -> store to shared -> update dapasource
  func update() {
    UserRequest().send { result in
      switch result{
      case.success(let users):
        self.model.usersByID = users
      case.failure:
        self.model.usersByID = [:]
      }
      
      DispatchQueue.main.async {
        self.updateCollectionView()
      }
    }
  }
}

// MARK: - vc transaction
extension UserCollectionViewController{
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    let nextVC = UserDetailViewController(user: item.user)
    navigationController?.pushViewController(nextVC, animated: true)
    collectionView.deselectItem(at: indexPath, animated: false)
  }
}
