//
//  UserDetailViewController.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-10.
//

import UIKit

// MARK: - Class properties and init()
class UserDetailViewController: UIViewController {
  
  private let headerIdentifier = "HeaderView"
  private let headerKind = "SectionHeader"
  
  
  var user: User!
  var updateTimer : Timer?
  
  let profileImageView: UIImageView = {
    let imv = UIImageView()
    imv.translatesAutoresizingMaskIntoConstraints = false
    imv.image = UIImage(systemName: "person.crop.circle")
    return imv
  }()
  let userNameLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = UIFont.systemFont(ofSize: 32, weight: .regular)
    lb.textAlignment = .left
    lb.numberOfLines = 0
    return lb
  }()
  lazy var nameWrapper = HorizontalStackView(
    arrangedSubviews:[profileImageView, userNameLabel],
    spacing: 20,
    alignment: .fill,
    distribution: .fill
  )
  
  let bioLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    lb.textAlignment = .left
    lb.numberOfLines = 0
    return lb
  }()
  
  lazy var profileWrapper = VerticalStackView(
    arrangedSubviews: [nameWrapper, bioLabel],
    spacing: 20,
    alignment: .fill,
    distribution: .fill
  )
  
  let collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  init(user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Model and ViewModel
  typealias DataSourceType = UICollectionViewDiffableDataSource<ViewModel.Section, ViewModel.Item>
  typealias Item = UserDetailViewController.ViewModel.Item
  
  enum ViewModel {
    enum Section: Hashable, Comparable {
      case leading
      case category(_ category: Category)
      
      static func < (lhs: Section, rhs: Section) -> Bool {
        switch (lhs, rhs) {
        case (.leading, .category), (.leading, .leading):
          return true
        case (.category, .leading):
          return false
        case (category(let category1), category(let category2)):
          return category1.name > category2.name
        }
      }
    }
    
    typealias Item = HabitCount
  }
  
  struct Model {
    var userStats: UserStatistics?
    var leadingStats: UserStatistics?
  }
  
  var dataSource: DataSourceType!
  var model = Model()
  
}


// MARK: - View init
extension UserDetailViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateImage()
    
    setupUIViews()
    
    collectionView.register(HabitUserDetailCollectionViewCell.self, forCellWithReuseIdentifier: HabitUserDetailCollectionViewCell.UserDetailReusableIdentifier)
    
    collectionView.register(NamedSectionHeaderView.self,
                            forSupplementaryViewOfKind: headerKind,
                            withReuseIdentifier: headerIdentifier)
    
    
    dataSource = createDataSource()
    collectionView.dataSource = dataSource
    collectionView.collectionViewLayout = createLayout()
    
    update()
  }
  
  fileprivate func setupUIViews() {
    view.backgroundColor = .systemBackground
    collectionView.backgroundColor = .systemBackground
    
    let sa = view.safeAreaLayoutGuide
    view.addSubview(profileWrapper)
    profileWrapper.anchors(
      topAnchor: sa.topAnchor,
      leadingAnchor: sa.leadingAnchor,
      trailingAnchor: sa.trailingAnchor,
      bottomAnchor: nil,
      padding: .init(top: 20, left: 20, bottom: 0, right: 20)
    )
    
    NSLayoutConstraint.activate([
      profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
      profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 1.0)
    ])
    
    view.addSubview(collectionView)
    collectionView.anchors(
      topAnchor: profileWrapper.bottomAnchor,
      leadingAnchor: sa.leadingAnchor,
      trailingAnchor: sa.trailingAnchor,
      bottomAnchor: sa.bottomAnchor,
      padding: .init(top: 20, left: 0, bottom: 0, right: 0)
    )
    
    userNameLabel.text = user.name
    bioLabel.text = user.bio
  }
  
}


// MARK: - fetch data
extension UserDetailViewController{
  func updateImage(){
    ImageRequest(imageID: user.id).send { result in
      print(result)
        switch result {
        case .success(let image):
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        default: break
        }
    }
  }
  
  
  // fetch data
  func update() {

    UserStatisticsRequest(userIDs: [user.id]).send { result in
      switch result {
      case .success(let userStats):
        self.model.userStats = userStats[0]
      case .failure:
        self.model.userStats = nil
      }
      
      DispatchQueue.main.async {
        self.updateCollectionView()
      }
    }
    
    HabitLeadStatisticsRequest(userID: user.id).send { result in
      switch result {
      case .success(let userStats):
        self.model.leadingStats = userStats
      case .failure:
        self.model.leadingStats = nil
      }
      
      DispatchQueue.main.async {
        self.updateCollectionView()
      }
    }
  }
  func updateCollectionView() {
    
    guard let userStatistics = model.userStats,
          let leadingStatistics = model.leadingStats else { return }
    
    var itemsBySection = userStatistics.habitCounts.reduce(into: [ViewModel.Section: [ViewModel.Item]]()) { partial, habitCount in
      
      let section: ViewModel.Section
      
      if leadingStatistics.habitCounts.contains(habitCount) {
        section = .leading
      } else {
        section = .category(habitCount.habit.category)
      }
      
      partial[section, default: []].append(habitCount)
    }
    
    itemsBySection = itemsBySection.mapValues { $0.sorted() }
    
    let sectionIDs = itemsBySection.keys.sorted()
    

    dataSource.applySnapshotUsing(sectionIDs: sectionIDs, itemsBySection: itemsBySection)
  }
  
}

// MARK: - data source
extension UserDetailViewController{
  // create data source
  func createDataSource() -> DataSourceType {
    let dataSource = DataSourceType(collectionView: collectionView) {
      (collectionView, indexPath, habitStat) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitUserDetailCollectionViewCell.UserDetailReusableIdentifier, for: indexPath) as!
        HabitUserDetailCollectionViewCell
      
      cell.primaryTextLabel.text = habitStat.habit.name
      cell.secondaryTextLabel.text = "\(habitStat.count)"
      
      return cell
    }
    
    dataSource.supplementaryViewProvider = { (collectionView,
                                              category, indexPath) in
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: self.headerKind, withReuseIdentifier: self.headerIdentifier, for: indexPath) as! NamedSectionHeaderView
      
      let section =
        dataSource.snapshot().sectionIdentifiers[indexPath.section]
      
      switch section {
      case .leading:
        header.nameLabel.text = "Leading"
      case .category(let category):
        header.nameLabel.text = category.name
      }
      
      return header
    }
    
    return dataSource
  }
}

// MARK: - collection view layout
extension UserDetailViewController{
  func createLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
  
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(36))
    let sectionHeader =  NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
    sectionHeader.pinToVisibleBounds = true
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
    section.boundarySupplementaryItems = [sectionHeader]
    
    return UICollectionViewCompositionalLayout(section: section)
  }
}

// MARK: - auto reload (fetch)
extension UserDetailViewController {
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    update()
    updateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      self.update()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    updateTimer?.invalidate()
    updateTimer = nil
  }
}
