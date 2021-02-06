//
//  CollectionViewController.swift
//  MyRestaurants
//
//  Created by Takayuki Yamaguchi on 2021-02-04.
//

import UIKit



class CollectionViewController: UICollectionViewController {
    
    private var tagGridId = "tagGrid"
    private var tagColumnId = "tagColumn"
    private var itemGridId = "itemGrid"
    private var itemColumnId = "itemColumn"
    private lazy var tagReuseIdentifier = activeLayout == .grid ? tagGridId : tagColumnId
    private lazy var itemReuseIdentifier = activeLayout == .grid ? itemGridId : itemColumnId
    
    var itemTagIds = movieGenre.map {$0.key}
    var items = Movie.sampleData
    
    var itemsSnapshot: NSDiffableDataSourceSnapshot<Section, SectionDataType>!
    var dataSource: UICollectionViewDiffableDataSource<Section, SectionDataType>!
    
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
        self.collectionView!.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: tagGridId)
        self.collectionView!.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: tagColumnId)
        self.collectionView!.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: itemGridId)
        self.collectionView!.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: itemColumnId)
        createSnapshot()
        createDataSource()
        
        // Collection View config : Layout
        collectionView.backgroundColor = .systemBackground
        activeLayout = .grid // This will automatically set leftButton and layout.
        collectionView.allowsMultipleSelection = true
        
        // Navigation bar config
        navigationItem.title = "Trend Movies"

        
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
                    cell.updateCell(item: movie)
                }
                return cell
            default:
                return UICollectionViewCell()
            }
        })
        
        
        dataSource.apply(itemsSnapshot)
    }
    
    func updateItems() {
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
            }.map {SectionDataType.main($0)} // Convert movie to SectionDataType
            
            itemsSnapshot.deleteSections([.main])
            itemsSnapshot.appendSections([.main])
            itemsSnapshot.appendItems(filteredItems)
            dataSource.apply(itemsSnapshot, animatingDifferences: true, completion: nil)
        }else{
            // restored all data
            itemsSnapshot.deleteSections([.main])
            itemsSnapshot.appendSections([.main])
            itemsSnapshot.appendItems(items.map({SectionDataType.main($0)}))
            dataSource.apply(itemsSnapshot, animatingDifferences: true, completion: nil)
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateItems()
    }
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        updateItems()
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
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        
        let numOfColumns = { () -> Int in
            switch style{
            case .grid:
                return 2
            case .column:
                return 1
            }
        }()
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth((2/3)/CGFloat(numOfColumns))
            ),
            subitem: item,
            count: numOfColumns
        )
        
        let section = NSCollectionLayoutSection(group: group)
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

