//
//  HabitDetailViewController.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-10.
//

import UIKit
// MARK: - Class properties and init()
class HabitDetailViewController: UIViewController {
  
  var habit: Habit!
  var updateTimer: Timer?
  
  let nameLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = UIFont.systemFont(ofSize: 32, weight: .bold)
    lb.textAlignment = .left
    lb.numberOfLines = 1
    return lb
  }()
  let categoryLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    lb.textAlignment = .right
    lb.numberOfLines = 1
    return lb
  }()
  lazy var nameCategoryWrapper = HorizontalStackView(
    arrangedSubviews:[nameLabel, categoryLabel],
    spacing: 12,
    alignment: .firstBaseline,
    distribution: .equalSpacing
  )
  
  let infoLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    lb.textAlignment = .left
    lb.numberOfLines = 0
    return lb
  }()
  lazy var allWrapper = VerticalStackView(
    arrangedSubviews: [nameCategoryWrapper, infoLabel],
    spacing: 16,
    alignment: .fill,
    distribution: .fill
  )
  
  let collectionView : UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  init(habit: Habit) {
    self.habit = habit
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Model and ViewModel
  typealias DataSourceType = UICollectionViewDiffableDataSource<ViewModel.Section, ViewModel.Item>
  typealias Item = HabitDetailViewController.ViewModel.Item
  
  enum ViewModel {
    enum Section: Hashable {
      case leaders(count: Int)
      case remaining
    }
    
    enum Item: Hashable, Comparable {
      case single(_ stat: UserCount)
      case multiple(_ stats: [UserCount])
      
      static func < (lhs: Item, rhs: Item) -> Bool {
        switch (lhs, rhs) {
        case (.single(let lCount), .single(let rCount)):
          return lCount.count < rCount.count
        case (.multiple(let lCounts), .multiple(let rCounts)):
          return lCounts.first!.count < rCounts.first!.count
        case (.single, .multiple):
          return false
        case (.multiple, .single):
          return true
        }
      }
    }
  }
  
  struct Model {
    var habitStatistics: HabitStatistics?
    var userCounts: [UserCount] {
      habitStatistics?.userCounts ?? []
    }
  }
  
  var dataSource: DataSourceType!
  var model = Model()
  
  
  
}

// MARK: - View initialization
extension HabitDetailViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    collectionView.backgroundColor = .systemBackground
    
    collectionView.register(HabitUserDetailCollectionViewCell.self, forCellWithReuseIdentifier: HabitUserDetailCollectionViewCell.HabitDetailReusableIdentifier)
    
    dataSource = createDataSource()
    collectionView.dataSource = dataSource
    collectionView.collectionViewLayout = createLayout()
    update()
    
    setupUIViews()
    
  }
  
  fileprivate func setupUIViews() {
    view.addSubview(allWrapper)
    let sa = view.safeAreaLayoutGuide
    allWrapper.anchors(
      topAnchor: sa.topAnchor,
      leadingAnchor: sa.leadingAnchor,
      trailingAnchor: sa.trailingAnchor,
      bottomAnchor: nil,
      padding: .init(top: 20, left: 12, bottom: 0, right: 12)
    )
    
    view.addSubview(collectionView)
    collectionView.anchors(
      topAnchor: allWrapper.bottomAnchor,
      leadingAnchor: sa.leadingAnchor,
      trailingAnchor: sa.trailingAnchor,
      bottomAnchor: sa.bottomAnchor,
      padding: .init(top: 20, left: 0, bottom: 0, right: 0)
    )
    
    nameLabel.text = habit.name
    categoryLabel.text = habit.category.name
    infoLabel.text = habit.info
  }
}


// MARK: - fetch data
extension HabitDetailViewController{
  // fetch data
  func update() {
    HabitStatisticsRequest(habitNames: [habit.name]).send { result in
      switch result {
      case .success(let statistics):
        if statistics.count > 0 {
          self.model.habitStatistics = statistics[0]
        } else {
          self.model.habitStatistics = nil
        }
      default:
        self.model.habitStatistics = nil
      }
      DispatchQueue.main.async {
        self.updateCollectionView()
      }
    }
  }
  
}

// MARK: - data source
extension HabitDetailViewController{
  // create data source
  func createDataSource() -> DataSourceType {
    return DataSourceType(collectionView: collectionView) {
      (collectionView, indexPath, grouping) -> UICollectionViewCell? in
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitUserDetailCollectionViewCell.HabitDetailReusableIdentifier, for: indexPath) as! HabitUserDetailCollectionViewCell
      
      switch grouping {
      case .single(let userStat):
        cell.primaryTextLabel.text = userStat.user.name
        cell.secondaryTextLabel.text = "\(userStat.count)"
      default:
        break
      }
      
      return cell
    }
  }
  
  // update snapshot and apply to data source
  func updateCollectionView() {
    let items = (self.model.habitStatistics?.userCounts.map { ViewModel.Item.single($0) } ?? []).sorted(by: >)
    
    dataSource.applySnapshotUsing(sectionIDs: [.remaining], itemsBySection: [.remaining: items])
  }
}

// MARK: - collection view layout
extension HabitDetailViewController{
  func createLayout() -> UICollectionViewCompositionalLayout {
    let itemSize =  NSCollectionLayoutSize(
      widthDimension  : .fractionalWidth(1),
      heightDimension : .fractionalHeight(1)
    )
    let item = NSCollectionLayoutItem(
      layoutSize: itemSize
    )
    item.contentInsets = NSDirectionalEdgeInsets(
      top     : 12,
      leading : 12,
      bottom  : 12,
      trailing: 12
    )
    
    let groupSize =  NSCollectionLayoutSize(
      widthDimension  : .fractionalWidth(1),
      heightDimension : .absolute(44)
    )
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitem   : item,
      count     : 1
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(
      top     : 20,
      leading : 0,
      bottom  : 20,
      trailing: 0
    )
    
    return UICollectionViewCompositionalLayout(section: section)
  }
}

// MARK: - auto reload (fetch)
extension HabitDetailViewController {
  
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
