//
//  CollectionViewController.swift
//  MyRestaurants
//
//  Created by Takayuki Yamaguchi on 2021-02-04.
//

import UIKit



class CollectionViewController: UICollectionViewController, UISearchControllerDelegate {
    

    private lazy var tagReuseIdentifier = "tag"
    private var itemGridId = "itemGrid"
    private var itemColumnId = "itemColumn"
    private lazy var itemReuseIdentifier = activeLayout == .grid ? itemGridId : itemColumnId
    
    var itemTagIds = movieGenre.map {$0.key}
    var items = Movie.sampleData
    
    var itemsSnapshot: NSDiffableDataSourceSnapshot<Section, SectionDataType>!
    var dataSource: UICollectionViewDiffableDataSource<Section, SectionDataType>!
    
    let searchController = UISearchController()
    
    lazy var gridButtonItem =  UIBarButtonItem(image: UIImage(systemName: "rectangle.grid.2x2"), style: .plain, target: self, action: #selector(leftButtonTapped))
    lazy var columnButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.grid.1x2"), style: .plain, target: self, action: #selector(leftButtonTapped))
    
    lazy var layout: [Layout: UICollectionViewCompositionalLayout] = {
        var l: [Layout: UICollectionViewCompositionalLayout] = [:]
        l[.grid] = createLayout(style: .grid)
        l[.column] = createLayout(style: .column)
        return l
    }()
    
    // Depend of active(current) Layout, set CollectionViewLayout and left button.
    lazy var activeLayout : Layout = .grid{
        didSet{
            if let viewLayout = layout[activeLayout]{
                
                // update view layout
                collectionView.setCollectionViewLayout(viewLayout, animated: true){ [weak self] _ in
                    guard let activeLayout = self?.activeLayout else{return}
                    
                    // update icon
                    switch activeLayout{
                    case .grid:
                        self?.navigationItem.leftBarButtonItem = self?.gridButtonItem
                    case .column:
                        self?.navigationItem.leftBarButtonItem = self?.columnButtonItem
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Collection View config : Data
        self.collectionView!.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: tagReuseIdentifier)
        self.collectionView!.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: itemGridId)
        self.collectionView!.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: itemColumnId)
        createSnapshot()
        createDataSource()
        
        // Collection View config : Layout
        collectionView.backgroundColor = .label
        activeLayout = .grid // This will automatically set leftButton and layout.
        collectionView.allowsMultipleSelection = true
        
        // Navigation bar config
        navigationItem.title = "Trend Movies"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.8)]
        navigationController?.navigationBar.tintColor = UIColor.systemPink.withAlphaComponent(0.8)
        navigationController?.navigationBar.barTintColor = .black
        setUpSearchController()
        
    
    }
    
    @objc func leftButtonTapped(_ sender: UIBarButtonItem){
        switch activeLayout {
        case .grid:
            activeLayout = .column
        case .column:
            activeLayout = .grid
        }
    }
}



// MARK: - DataSource config
extension CollectionViewController{
    private func createSnapshot(){
        itemsSnapshot = NSDiffableDataSourceSnapshot<Section, SectionDataType>()
        itemsSnapshot.appendSections([.header,.main])
        itemTagIds.forEach{ tagId in
            itemsSnapshot.appendItems([.header(tagId)], toSection: .header)
        }
        items.forEach{ item in
            itemsSnapshot.appendItems([.main(item)], toSection: .main)
        }
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, SectionDataType>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            
            switch indexPath.section{
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.tagReuseIdentifier, for: indexPath) as! TagCollectionViewCell
                if case .header(let tagId) = item{
                    cell.updateCell(str: movieGenre[tagId]!) 
                }
                return cell
                
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.itemReuseIdentifier, for: indexPath) as! ItemCollectionViewCell
                if case .main(let movie) = item{
                    cell.item = movie
                }
                return cell
            default:
                return UICollectionViewCell()
            }
        })
        
        
        dataSource.apply(itemsSnapshot)
    }
}

// MARK: - Display Detail
extension CollectionViewController: UIViewControllerTransitioningDelegate{
    
    func displayDetail(indexPath: IndexPath) {

        // get current selected cell
        guard let cell = collectionView!.cellForItem(at: indexPath) as? ItemCollectionViewCell else {return}
        // create nextVC base on current cell
        let nextVC = ItemDetailViewController(item: cell.item, image: cell.imageView.image)
        
        // This will cover all screen
        nextVC.modalPresentationStyle = .overCurrentContext
        // This enable to use custom transition
        nextVC.transitioningDelegate = self
        
        // If you're using Search Bar controller, it's "presented"
        // You can present two VC at same time, so get the current presented view and try to present on that.
        if let presentedVC = self.presentedViewController{
            presentedVC.present(nextVC, animated: true, completion: nil)
        }else{
            self.present(nextVC, animated: true, completion: nil)
        }
        
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // By doing this, you can get current cell frame (pop up from that place!)
//        guard let selectedIndexPath =  collectionView.indexPathsForSelectedItems?.first,
//           let selectedItemCell = collectionView!.cellForItem(at: selectedIndexPath) as? ItemCollectionViewCell,
//           let selectedItemCellSuperview = selectedItemCell.superview
//           else{return nil}
//        let cellFrame = selectedItemCellSuperview.convert(selectedItemCell.frame, to: nil)
//
        PopAnimator.shared.presenting = true
        return PopAnimator.shared
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PopAnimator.shared.presenting = false
        return PopAnimator.shared
    }
}




// MARK: - Filter items config
extension CollectionViewController{
    // If cell is selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // if header is tap -> filter item, otherwise, display dettail
        if indexPath.section == 0{
            filterItems()
        }else{
            displayDetail(indexPath: indexPath)
            // as soon as item is selected, deselect item (I don't want to keep item selected)
            collectionView.deselectItem(at: indexPath, animated: false)
        }
        
    }
    // If cell is deselected
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0{
            filterItems()
        }else{
            displayDetail(indexPath: indexPath)
        }
        
    }
    
    // if search bar results is updated
    func updateSearchResults(for searchController: UISearchController) {
        filterItems()
    }
    
    
    // Filter items by both tags and search bar.
    func filterItems() {
        let itemsFilteredByTags =  filterByTags(items: items)
        let itemsFilteredByTagsAndSearchText = filterBySearchText(items: itemsFilteredByTags)
        updateDataSourceByKeepingItems(filteredItems: itemsFilteredByTagsAndSearchText)
    }
    
    
    /// This will filter items by current selected Tags
    /// - Parameters:
    ///   - items: Items you want to filter
    /// - Returns: Filtered items. If there is no items, it will return unfiltered passed items.
    func filterByTags(items: [Movie]) -> [Movie] {
        let selectedIndexPaths = collectionView.indexPathsForSelectedItems
        if let selectedTagIds =  selectedIndexPaths?
            .filter({ $0.section == 0}) // get index path only in header(0) section [[0,2],[0,5]]
            .compactMap({$0[1]}) // get only item(row) element [2,5]
            .map({itemTagIds[$0]}), // get actually genre Id array [223, 5463]
           selectedTagIds.count > 0 // and if more than 1 tags are selected
        {
            // Decide What items to keep
            let filteredItems = items.filter { (movie) -> Bool in
                movie.genre.contains { (genreId) -> Bool in
                    return selectedTagIds.contains(genreId)
                }
            }
            return filteredItems
        }else{
            // restored all data
            return items
        }
    }
    
    
    /// This will filter items by current search bar text
    /// - Parameters:
    ///   - items: Items you want to filter
    /// - Returns: Filtered items. If there is no items, it will return unfiltered passed items.
    func filterBySearchText(items: [Movie]) -> [Movie] {
        if let searchString = searchController.searchBar.text, !searchString.isEmpty{
            let filteredItems = items.filter({$0.title.localizedCaseInsensitiveContains(searchString)})
            return filteredItems
        }else{
            return items
        }
    }
    
    
    /// This will update and apply snapshot and data source by items you want to keep
    /// - Parameter filteredItems: the items you want to keep
    func updateDataSourceByKeepingItems(filteredItems: [Movie]){
        itemsSnapshot.deleteSections([.main])
        itemsSnapshot.appendSections([.main])
        itemsSnapshot.appendItems(filteredItems.map({SectionDataType.main($0)}))
        dataSource.apply(itemsSnapshot, animatingDifferences: true, completion: nil)
    }
}


// MARK: - Search Bar config
extension CollectionViewController: UISearchResultsUpdating{
    
    func setUpSearchController(){
        searchController.searchResultsUpdater = self // like delegate = self
        searchController.obscuresBackgroundDuringPresentation  = false // disable dark background
        searchController.searchBar.placeholder = "Search Titles"
        navigationItem.searchController = searchController
        collectionView.setContentOffset(.zero, animated: false)
        
    }
    
    
    // This will show search bar without scrolling by default
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      UIView.performWithoutAnimation {
        navigationItem.searchController?.isActive = true
        navigationItem.searchController?.isActive = false
      }
    }
}



// MARK: - Layout config
extension CollectionViewController{
    
    func createLayout(style: Layout) -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch sectionIndex {
            case 0:
                return self?.createHeaderSection()
            case 1:
                return self?.createBodySection(style: style)
            default:
                return nil
            }
        }
        
    }
 
    func createHeaderSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .estimated(100), // override layter
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: item.layoutSize.widthDimension,
                heightDimension: .absolute(30)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8
        return section
    }
    
    
    func createBodySection(style: Layout)-> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0), // override layter
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        
        let group = { () -> NSCollectionLayoutGroup in
            switch style{
            case .grid:
                return NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalWidth(3/4)
                    ),
                    subitem: item,
                    count: 2
                )
            case .column:
                return NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalWidth(2/3)
                    ),
                    subitem: item,
                    count: 1
                )
            }
        }()
        
        
        group.contentInsets = .init(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 4, leading: 0, bottom: 4, trailing: 0)
        return section
    }

}


// MARK: - Enum

enum Section: String {
    case header = "Header"
    case main = "Main"
}
enum SectionDataType: Hashable {
    case header(Int)
    case main(Movie)
}

enum Layout {
    case grid
    case column
}

