//
//  HabitCollectionViewController.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-10.
//

import UIKit

private let reuseIdentifier = "ListCell"


// MARK: - Define Model and View model
class HabitCollectionViewController: UICollectionViewController {
  // Rename dataType as simple
  typealias DataSourceType = UICollectionViewDiffableDataSource<ViewModel.Section, ViewModel.Item>
  typealias SnapshotType = NSDiffableDataSourceSnapshot<ViewModel.Section, ViewModel.Item>
  
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
    self.collectionView!.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    dataSource = createDataSource()
    collectionView.dataSource = dataSource
    collectionView.collectionViewLayout = createLayout()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    update()
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
    let dataSource = DataSourceType(collectionView: collectionView) {
      (collectionView, indexPath, item) in
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UICollectionViewListCell
      
      var content = UIListContentConfiguration.valueCell()
      content.text = item.habit.name
      cell.contentConfiguration = content
      return cell
    }
    
    return dataSource
  }
}


// MARK: - Create layout
extension HabitCollectionViewController {
  func createLayout() -> UICollectionViewCompositionalLayout {
    
    return UICollectionViewCompositionalLayout{(sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      
      var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
      config.backgroundColor = .systemBackground
      let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
      
      return section
    }
    
  }
}
