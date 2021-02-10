//
//  CollectionViewController.swift
//  MyRestaurants
//
//  Created by Takayuki Yamaguchi on 2021-02-04.
//

import UIKit

// MARK: - Enum

enum Section: Hashable {
    case headerTag
    case showcase
    case list
}

enum SupplementaryViewKind {
  static let header = "header"
}

enum Layout {
    case grid
    case column
}


class CollectionViewController: UICollectionViewController, UISearchControllerDelegate {
    

    private lazy var tagReuseIdentifier = "tag"
    private var itemGridId = "itemGrid"
    private var itemColumnId = "itemColumn"
    private lazy var itemReuseIdentifier = activeLayout == .grid ? itemGridId : itemColumnId
    private let itemListReuseIdentifier = "list"

    var itemTagIds = SectionData.allTagIds.map{$0.tagId}
    var items = SectionData.allMovies.map{$0.movie!}
    
    let sections : [Section] = [.headerTag, .showcase, .list]
    var itemsSnapshot: NSDiffableDataSourceSnapshot<Section, SectionData>!
    var dataSource: UICollectionViewDiffableDataSource<Section, SectionData>!
    
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
        
        // list
        self.collectionView!.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: itemListReuseIdentifier)

        // header
        self.collectionView!.register(SectionHeaderView.self, forSupplementaryViewOfKind: SupplementaryViewKind.header, withReuseIdentifier: SectionHeaderView.firstReuseIdentifier)
        self.collectionView!.register(SectionHeaderView.self, forSupplementaryViewOfKind: SupplementaryViewKind.header, withReuseIdentifier: SectionHeaderView.secondReuseIdentifier)

        createSnapshot()
        createDataSource()
        // Collection View config : Layout
        collectionView.backgroundColor = .label
        activeLayout = .grid // This will automatically set leftButton and layout.
        collectionView.allowsMultipleSelection = true
        // Scroll to top by default
        collectionView.setContentOffset(.zero, animated: false)
        
        // Navigation bar config
        navigationItem.title = "My Movies"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.8)]
        navigationController?.navigationBar.tintColor = UIColor.systemPink.withAlphaComponent(0.8)
        navigationController?.navigationBar.barTintColor = .black
        setUpSearchController()
        

        // This is to adjust dynamic cell size
        collectionView.reloadData()
        
        

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
        itemsSnapshot = NSDiffableDataSourceSnapshot<Section,SectionData>()
        itemsSnapshot.appendSections([.headerTag,.showcase, .list])
        
        itemsSnapshot.appendItems(SectionData.allTagIds, toSection: .headerTag)

        itemsSnapshot.appendItems(SectionData.allMovies, toSection: .showcase)
        itemsSnapshot.appendItems(SectionData.allMoviesForList, toSection: .list)
        

    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, SectionData>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch self.sections[indexPath.section]{
            case .headerTag:
                // Set cell
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.tagReuseIdentifier, for: indexPath) as! TagCollectionViewCell
                
                if let tagId = item.tagId, let genreName = SectionData.movieGenres[tagId]{
                    cell.updateCell(str: genreName)
                }

                return cell
                
            case .showcase:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.itemReuseIdentifier, for: indexPath) as! ItemCollectionViewCell
                cell.item = item.movie
                return cell
            case .list:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.itemListReuseIdentifier, for: indexPath) as! UICollectionViewListCell

                var content = UIListContentConfiguration.valueCell()
                
                // Set main title
                content.text = item.movie?.title
                // change main title color
                content.textProperties.color = UIColor.white.withAlphaComponent(0.8)
                
                // Set second title
                content.secondaryTextProperties.color = UIColor.white.withAlphaComponent(0.2)
                content.secondaryText = SectionData.getGenreNames(genreIds: item.movie!.genre)
    
                // Don't allow main text and second text in same line
                content.prefersSideBySideTextAndSecondaryText = false
                
                // apply config
                cell.contentConfiguration = content
                // Set accessories with color
                cell.accessories = [.reorder(displayed: .always),.disclosureIndicator(options: .init(tintColor: UIColor.systemPink.withAlphaComponent(0.6)))]
 
                // change bg color of cell
                cell.backgroundConfiguration?.backgroundColor = UIColor.gray.withAlphaComponent(0.1)


                return cell

            }
        })
        
        
        dataSource.supplementaryViewProvider = {[weak self] collectionView, kind, indexPath -> UICollectionReusableView? in
            guard let self = self  else {return nil}
            
            switch self.sections[indexPath.section] {
            case .showcase:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: SupplementaryViewKind.header, withReuseIdentifier: SectionHeaderView.firstReuseIdentifier, for: indexPath) as! SectionHeaderView
                
                headerView.setTitle("Trending")
                
                return headerView
            case .list:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: SupplementaryViewKind.header, withReuseIdentifier: SectionHeaderView.secondReuseIdentifier, for: indexPath) as! SectionHeaderView
                
                headerView.setTitle("Watched history")
                headerView.setTopSpace(top: 0)
                return headerView
            default:
                return nil
            }
            
            
        }
            
        // Reorder config
        // only list view is allowed to reorder
        dataSource.reorderingHandlers.canReorderItem = { item in
            if let movie = item.movie, movie.id == -1{return true}
            return false
        }
        dataSource.reorderingHandlers.didReorder = { [weak self] transaction in
            guard let self = self else { return }
            self.itemsSnapshot =  transaction.finalSnapshot
        }
        
        
        dataSource.apply(itemsSnapshot)
    }
}

// MARK: - Display Detail
extension CollectionViewController: UIViewControllerTransitioningDelegate{
    
    func slideToDetail(indexPath: IndexPath) {
        
        // under construction!
        
        // get current selected cell
//        guard let cell = collectionView!.cellForItem(at: indexPath) as? UICollectionViewListCell else {return}
        
        let nextVC = ItemDetailViewController()
        nextVC.view.backgroundColor  = .systemTeal
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func popupDetail(indexPath: IndexPath) {

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
        switch sections[indexPath.section]{
        case .headerTag:
            filterItems()
        case .showcase:
            popupDetail(indexPath: indexPath)
            // as soon as item is selected, deselect item (I don't want to keep item selected)
            collectionView.deselectItem(at: indexPath, animated: false)
        case .list:
            slideToDetail(indexPath: indexPath)
        }
    }
    
    // If cell is deselected
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        switch sections[indexPath.section]{
        case .headerTag:
            filterItems()
        case .showcase:
            popupDetail(indexPath: indexPath)
        case .list:
            return
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
        updateDataSourceWithKeepingItems(filteredItems: itemsFilteredByTagsAndSearchText)
    }
    
    
    /// This will filter items by current selected Tags
    /// - Parameters:
    ///   - items: Items you want to filter
    /// - Returns: Filtered items. If there is no items, it will return unfiltered passed items.
    func filterByTags(items: [Movie]) -> [Movie] {
        let selectedIndexPaths = collectionView.indexPathsForSelectedItems
        if let selectedTagIds =  selectedIndexPaths?
            .filter({ sections[$0.section] == .headerTag}) // get index path only in header(0) section [[0,2],[0,5]]
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
    func updateDataSourceWithKeepingItems(filteredItems: [Movie]){
        
        // reset all items in second section
        itemsSnapshot.deleteSections([.showcase])
        itemsSnapshot.insertSections([.showcase], afterSection: .headerTag)
        itemsSnapshot.appendItems(filteredItems.map({SectionData.movie($0)}), toSection: .showcase)
        dataSource.apply(itemsSnapshot, animatingDifferences: true, completion: nil)
    }
}


// MARK: - Search Bar config
extension CollectionViewController: UISearchResultsUpdating{
    
    func setUpSearchController(){
        searchController.searchResultsUpdater = self // like delegate = self
        searchController.obscuresBackgroundDuringPresentation  = false // disable dark background
        searchController.searchBar.placeholder = "Search Titles"
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
}



// MARK: - Layout config
extension CollectionViewController{
    
    func createLayout(style: Layout) -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch self?.sections[sectionIndex] {
            case .headerTag:
                return self?.createHeaderSection()
            case .showcase:
                return self?.createBodySection(style: style)
            case .list:
                return self?.createListSection(layoutEnvironment)
            case .none:
                return nil
            }
        }
        
    }
 
    func createHeaderSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .estimated(80),
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
        section.interGroupSpacing = 12
        section.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
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
                        heightDimension: .fractionalWidth(4/3)
                    ),
                    subitem: item,
                    count: 1
                )
            }
        }()
        
        
        group.contentInsets = .init(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        let section = NSCollectionLayoutSection(group: group)
       
        
        
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(40)
          ),
          elementKind: SupplementaryViewKind.header,
            alignment: .top
        )
        headerItem.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 0)


        section.boundarySupplementaryItems = [headerItem]
        
        section.contentInsets = .init(top: 4, leading: 0, bottom: 4, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return section
    }
    
    func createListSection(_ env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.backgroundColor = .black
        let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: env)
        
        
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(30)
          ),
          elementKind: SupplementaryViewKind.header,
            alignment: .top
        )
        headerItem.contentInsets = .init(top: 0, leading: 4, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [headerItem]
        section.contentInsets = .init(top: 12, leading: 8, bottom: 8, trailing: 8)
        return section
    }

}



