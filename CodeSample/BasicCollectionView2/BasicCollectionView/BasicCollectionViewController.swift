//
//  BasicCollectionViewController.swift
//  BasicCollectionView
//
//  Created by Derrick Park on 2021-02-02.
//

import UIKit

private let reuseIdentifier       = "StateCell"
private let headerReuseIdentifier = "HeaderStateCell"

class BasicCollectionViewController: UICollectionViewController, UISearchResultsUpdating {

  private let items
    = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]

  lazy var filteredItems: [String] = self.items

  lazy var itemsByInitialLetter: [Character: [String]]
    = self.filteredItems.reduce([:]) { (existing, element) in
    return existing.merging([element.first!: [element]]) { (old, new) in
      return old + new // appending "Alaska" to ['A': ["Alabama", "Alaska"]]
    }
  }

  lazy var initialLetters: [Character] = itemsByInitialLetter.keys.sorted()

  var dataSource: UICollectionViewDiffableDataSource<Character, String>!

  var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Character, String> {
    var snapshot = NSDiffableDataSourceSnapshot<Character, String>()
    for section in initialLetters {
      snapshot.appendSections([section])
      snapshot.appendItems(
        itemsByInitialLetter[section]!) // added to recently added section
    }

    return snapshot
  }

  // 1. create a searchController
  let searchController = UISearchController()

  func updateSearchResults(for searchController: UISearchController) {
    if let searchString = searchController.searchBar.text, !searchString.isEmpty {
      filteredItems = items.filter(
        { $0.localizedCaseInsensitiveContains(searchString) })
    } else {
      filteredItems = items
    }

    itemsByInitialLetter = self.filteredItems.reduce(
      [:]) { (existing, element) in
      return existing.merging([element.first!: [element]]) { (old, new) in
        return old + new // appending "Alaska" to ['A': ["Alabama", "Alaska"]]
      }
    }

    initialLetters = itemsByInitialLetter.keys.sorted()

    // collectionView.reloadData()
    // filteredItemsSnapshot is a computed property
    dataSource.apply(filteredItemsSnapshot, animatingDifferences: true,
      completion: nil)
  }

  private func createDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Character, String>(
      collectionView: collectionView,
      cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
        let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: reuseIdentifier,
          for: indexPath) as! BasicCollectionViewCell
        cell.label.text = item
        return cell
      })

    dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
      let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
        withReuseIdentifier: headerReuseIdentifier,
        for: indexPath) as! BasicHeaderView
      header.label.text = String(self.initialLetters[indexPath.section])
      return header
    }
    dataSource.apply(filteredItemsSnapshot)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.searchController = searchController
    searchController.searchResultsUpdater = self // delegate that will handle the actual filtering
    searchController.obscuresBackgroundDuringPresentation = false

    collectionView.backgroundColor = .white
    collectionView.setCollectionViewLayout(generateComplexLayout(),
      animated: false)
    collectionView.register(BasicCollectionViewCell.self,
      forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.register(BasicHeaderView.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: headerReuseIdentifier)
    createDataSource()
  }

  private func generateComplexLayout() -> UICollectionViewLayout {
    let spacing: CGFloat = 2
    // Style 1: 'Full' with item
    let fullItem         = NSCollectionLayoutItem(
      layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalWidth(2 / 3)))
    fullItem.contentInsets = NSDirectionalEdgeInsets(top: spacing,
      leading: spacing, bottom: spacing, trailing: spacing)

    // Style 2: 'Main with pair'
    let mainItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(2 / 3),
      heightDimension: .fractionalHeight(1.0)))
    mainItem.contentInsets = NSDirectionalEdgeInsets(top: spacing,
      leading: spacing, bottom: spacing, trailing: spacing)

    let pairItem = NSCollectionLayoutItem(
      layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(0.5)))
    pairItem.contentInsets = NSDirectionalEdgeInsets(top: spacing,
      leading: spacing, bottom: spacing, trailing: spacing)

    let trailingGroup = NSCollectionLayoutGroup.vertical(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1 / 3),
        heightDimension: .fractionalHeight(1.0)), subitem: pairItem, count: 2)

    let mainWithTrailingGroup = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalWidth(4 / 9)),
      subitems: [mainItem, trailingGroup])

    // Style 3: 'Triplet' - three 1 / 3 width items stacked horizontally
    let tripletItem           = NSCollectionLayoutItem(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1 / 3),
        heightDimension: .fractionalHeight(1.0)))
    tripletItem.contentInsets = NSDirectionalEdgeInsets(top: spacing,
      leading: spacing, bottom: spacing, trailing: spacing)

    let tripletGroup              = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalWidth(2 / 9)),
      subitems: [tripletItem, tripletItem, tripletItem])

    // Style 4: Reversed Style 2
    let mainWithPairReversedGroup = NSCollectionLayoutGroup.horizontal(
      layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalWidth(4 / 9)),
      subitems: [trailingGroup, mainItem])

    let nestedGroups = NSCollectionLayoutGroup.vertical(
      layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalWidth(16 / 9)),
      subitems: [fullItem, mainWithTrailingGroup, tripletGroup, mainWithPairReversedGroup])

    let section       = NSCollectionLayoutSection(group: nestedGroups)
    let headerSize    = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(35))
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

    section.boundarySupplementaryItems = [sectionHeader]

    //    section.orthogonalScrollingBehavior = .groupPaging
    //    return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
    //      let layoutType = LayoutType.allCases[sectionIndex]
    //      switch (layoutType) {
    //      case .header:
    //        return section1
    //      case .main:
    //        return section2
    //      }
    //    }
    return UICollectionViewCompositionalLayout(section: section)
  }
}

//enum LayoutType: Int, CaseIterable {
//  case header
//  case main
//  // CaseIterable makes this static property
//  // static var allCases = [.header, .main]
//}
