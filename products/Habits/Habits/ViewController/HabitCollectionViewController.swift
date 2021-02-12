//
//  HabitCollectionViewController.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-10.
//

import UIKit

private let sectionHeaderKind = "SectionHeader"
private let sectionHeaderIdentifier = "HeaderView"


// MARK: - Define Model and View model
class HabitCollectionViewController: UICollectionViewController {
  // Rename dataType as simple
  typealias DataSourceType = UICollectionViewDiffableDataSource<ViewModel.Section, ViewModel.Item>

  
  // Wrapping section and item
  enum ViewModel {
    enum Section: Hashable, Equatable, Comparable  {
      
      static func < (lhs: Section, rhs: Section) -> Bool {
        switch (lhs, rhs) {
        case (.category(let l), .category(let r)):
          return l.name < r.name
        case (.favorites, _):
          return true
        case (_ , .favorites):
          return false
        }
      }
      
      case favorites
      case category(_ category: Category)
    }
    
    struct Item: Hashable, Equatable, Comparable {
      // This is to make absolute order (so that each time lists won't shuffle)
      static func < (lhs: Item, rhs: Item) -> Bool {
        return lhs.habit < rhs.habit
      }
      
      let habit: Habit
      let isFavorite: Bool
    }
  }
  
  // Create a model used in this class from user defaults
  struct Model{
    var habitByName = [String: Habit]()
    // return favoriteHabits from user defaults
    var favoriteHabits : [Habit]{
      return Settings.shared.favoriteHabits
    }
  }
  var model = Model()
  
  var dataSource  : DataSourceType!
  
}


// MARK: - Config View load
extension HabitCollectionViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .systemBackground
    
    // Register cell classes
    self.collectionView!.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.HabitReusableIdentifier)
    
    self.collectionView!.register(NamedSectionHeaderView.self, forSupplementaryViewOfKind: sectionHeaderKind , withReuseIdentifier: sectionHeaderIdentifier)
    
    dataSource = createDataSource()
    collectionView.dataSource = dataSource
    collectionView.collectionViewLayout = createLayout()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    update()
  }
  
  // If you do a long press at cell,
  override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
    
    let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
      
      let item = self.dataSource.itemIdentifier(for: indexPath)!
      let favoriteToggle = UIAction(title: item.isFavorite ? "Unfavorite" : "Favorite") { (action) in
        // if you did action -> toggle favorite status and update UI
        Settings.shared.toggleFavorite(item.habit)
        self.updateCollectionView()
      }
      return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [favoriteToggle])
    }
    return config
  }
}


// MARK: - Fetch and update model
extension HabitCollectionViewController {
  /// Fetch habit and update UI
  func update(){
    
    HabitRequest().send{ result in
      
      switch result{
      case .success (let habits):
        self.model.habitByName = habits
      case .failure:
        self.model.habitByName = [:]
      }
      
      DispatchQueue.main.async {
        self.updateCollectionView()
      }
      
    }
    
  }
}


// MARK: - Create Snapshot and apply to Data source form model
extension HabitCollectionViewController {
  /// Create a snapshot from current model and apply to data Srouce
  func updateCollectionView(){
    
    var itemsBySection = model.habitByName.values.reduce(into: [ViewModel.Section : [ViewModel.Item]]()) { (partial, habit) in
      
      let section: ViewModel.Section
      let item : ViewModel.Item
      
      //  favorite section ->  [favourite, [item, item, item, ...(all true) ]]
      if model.favoriteHabits.contains(habit){
        section = .favorites
        item = ViewModel.Item(habit: habit, isFavorite: true)
      }else{
        // category section -> [category, [item, item, item, ...(all false)]]
        section = .category(habit.category)
        item = ViewModel.Item(habit: habit, isFavorite: false)
      }
      
      partial[section, default:[]].append(item)
    }
    
    itemsBySection = itemsBySection.mapValues{$0.sorted()}
    // Create [section0, section1 ....] from all items value.
    let setionIDs = itemsBySection.keys.sorted()
    
    dataSource.applySnapshotUsing(sectionIDs: setionIDs, itemsBySection: itemsBySection)
  }
  
  func createDataSource() -> DataSourceType {
    
    // Config cell
    let dataSource = DataSourceType(collectionView: collectionView) {
      (collectionView, indexPath, item) in
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.HabitReusableIdentifier, for: indexPath) as! HabitCollectionViewCell
      
      cell.primaryTextLabel.text = item.habit.name
      return cell
    }
    
    // Config header(footer) view
    dataSource.supplementaryViewProvider = { (collectionView, kind,indexPath) in
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: sectionHeaderKind, withReuseIdentifier: sectionHeaderIdentifier, for: indexPath) as! NamedSectionHeaderView
      
      let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
      
      switch section {
      case .favorites:
        header.nameLabel.text = "Favorites"
      case .category(let category):
        header.nameLabel.text = category.name
      }
      
      return header
    }
    
    
    return dataSource
  }
}


// MARK: - Create layout
extension HabitCollectionViewController {
  func createLayout() -> UICollectionViewCompositionalLayout {
    
    return UICollectionViewCompositionalLayout{(sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      
      
      // Create list layout
      var config = UICollectionLayoutListConfiguration(appearance: .plain)
      config.backgroundColor = .systemBackground
      let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
      
      // Create header layout in section
      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(36))
      let sectionHeader =  NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: sectionHeaderKind, alignment: .top)
      sectionHeader.pinToVisibleBounds = true
//            sectionHeader.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
      
      section.contentInsets = NSDirectionalEdgeInsets(top: 0,leading: 8, bottom: 0, trailing: 8)
      section.boundarySupplementaryItems = [sectionHeader]
      
      return section
    }
    
  }
}






//
//extension HabitCollectionViewController{
//  func configSnapshot()  {
//    snapshot = SnapshotType()
//  }
//  func configDatasource()  {
//    //    dataSource
//  }
//}

//    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
//    let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//    let groupSize =
//      NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                             heightDimension: .absolute(44))
//    let group = NSCollectionLayoutGroup.horizontal(layoutSize:
//                                                    groupSize, subitem: item, count: 1)
//
//    let section = NSCollectionLayoutSection(group: group)
//    section.contentInsets = NSDirectionalEdgeInsets(top: 0,
//                                                    leading: 10, bottom: 0, trailing: 10)
//
//    return UICollectionViewCompositionalLayout(section: section)
