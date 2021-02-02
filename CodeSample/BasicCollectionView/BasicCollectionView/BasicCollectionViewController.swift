//
//  BasicCollectionViewController.swift
//  BasicCollectionView
//
//  Created by Derrick Park on 2021-02-02.
//

import UIKit

private let reuseIdentifier = "StateCell"

class BasicCollectionViewController: UICollectionViewController, UISearchResultsUpdating {
  
  private let items = [
      "Alabama", "Alaska", "Arizona", "Arkansas", "California",
      "Colorado", "Connecticut", "Delaware", "Florida",
      "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa",
      "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland",
      "Massachusetts", "Michigan", "Minnesota", "Mississippi",
      "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire",
      "New Jersey", "New Mexico", "New York", "North Carolina",
      "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania",
      "Rhode Island", "South Carolina", "South Dakota", "Tennessee",
      "Texas", "Utah", "Vermont", "Virginia", "Washington",
      "West Virginia", "Wisconsin", "Wyoming"
  ]
  
  lazy var filteredItems: [String] = self.items
  
  // 1. create a searchController
  let searchController = UISearchController()
  
  func updateSearchResults(for searchController: UISearchController) {
    if let searchString = searchController.searchBar.text, !searchString.isEmpty {
      filteredItems = items.filter({ $0.localizedCaseInsensitiveContains(searchString) })
    } else {
      filteredItems = items
    }
    collectionView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.searchController = searchController
    searchController.searchResultsUpdater = self // delegate that will handle the actual filtering
    searchController.obscuresBackgroundDuringPresentation = false
    
    collectionView.backgroundColor = .white
    collectionView.setCollectionViewLayout(generateLayout(), animated: false)
    collectionView.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
  }
  
  private func generateLayout() -> UICollectionViewLayout {
    let spacing: CGFloat = 10
    // 1. define item
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
    
    // 2. define group
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(70))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
    group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: 0, bottom: 0, trailing: 0)
    
    // 3. define section
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = spacing
    
    return UICollectionViewCompositionalLayout(section: section)
  }
 
  // MARK: - UICollectionViewDataSource
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filteredItems.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BasicCollectionViewCell
    
    cell.label.text = filteredItems[indexPath.item]
    
    return cell
  }
}
