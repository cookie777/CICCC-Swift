//
//  CollectionViewController.swift
//  MyRestaurants
//
//  Created by Takayuki Yamaguchi on 2021-02-04.
//

import UIKit

private let tagReuseIdentifier = Section.header.rawValue
private let itemReuseIdentifier = Section.main.rawValue
private let titleReuseIdentifier = "title"

class CollectionViewController: UICollectionViewController {

    var itemTagIds = movieGenre.map {$0.key}
    var items = Movie.sampleData
    
    var itemsSnapshot: NSDiffableDataSourceSnapshot<Section, SectionDataType>!
    var dataSource: UICollectionViewDiffableDataSource<Section, SectionDataType>!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set background
        collectionView.backgroundColor = .systemBackground
        
        // Register cell classes
        self.collectionView!.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: tagReuseIdentifier)
        self.collectionView!.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: itemReuseIdentifier)
//
//
//        collectionView.register(ItemTitleView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: titleReuseIdentifier)
//
        createSnapshot()
        createDataSource()
        
        // Set CollectionViewLayout
        collectionView.setCollectionViewLayout(createCollectionViewLayout(), animated: true)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        

        
        

    }

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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagReuseIdentifier, for: indexPath) as! TagCollectionViewCell
                if case .header(let tagId) = item{
                    cell.updateCell(str: movieGenre[tagId]!) 
                }
                return cell
                
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemReuseIdentifier, for: indexPath) as! ItemCollectionViewCell
                if case .main(let movie) = item{
                    cell.updateCell(item: movie)
                }
                return cell
            default:
                return UICollectionViewCell()
            }
        })
        
//        dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView?  in
//          let titleView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: titleReuseIdentifier, for: indexPath) as! ItemTitleView
//            titleView.label.text = self?.items[indexPath.item].title
//          return titleView
//        }
        dataSource.apply(itemsSnapshot)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }
//
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return 20
//    }
    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//
//        // Configure the cell
//
//        return cell
//    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}


extension CollectionViewController{
    
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in

            switch sectionIndex {
            case 0:
                return self?.createHeaderSection()
            case 1:
                return self?.createBodySection()
            default:
                return nil
            }
        }

    }
    
    func createHeaderSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .estimated(100), // override layter
                heightDimension: .estimated(30)
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: item.layoutSize.widthDimension,
                heightDimension: .estimated(30)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8
        return section
    }
    
    
    func createBodySection()-> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0), // override layter
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1/3)
            ),
            subitem: item,
            count: 2
        )
        let titleSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/5)
        )
//        NSCollectionLayoutSupplementaryItem(layoutSize: titleSize)
//        let itemHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .bottom)
//        group.supplementaryItems = [itemHeader]
        
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    


}

enum Section: String {
    case header = "Header"
    case main = "Main"
}
enum SectionDataType: Hashable {
    case header(Int)
    case main(Movie)
}


//
//var itemTagsSnapshot: NSDiffableDataSourceSnapshot<Int, Int>!
//var itemTagsDataSource: UICollectionViewDiffableDataSource<Int, Int>!
//
//var itemsSnapshot: NSDiffableDataSourceSnapshot<Int, Int>!
//var itemsDataSource: UICollectionViewDiffableDataSource<Int, Int>!
//
//private func createItemTagsSnapshot(){
//    itemTagsSnapshot = NSDiffableDataSourceSnapshot<Int, Int>()
//    itemTagsSnapshot.appendSections([0])
//    itemTagsSnapshot.appendItems(itemTags, toSection: 0)
//}
//private func createItemsTagsDataSource() {
//    itemTagsDataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
//        return cell
//    })
//    itemTagsDataSource.apply(itemTagsSnapshot)
//}
//
//private func createItemsSnapshot(){
//    itemsSnapshot = NSDiffableDataSourceSnapshot<Int, Int>()
//    itemsSnapshot.appendSections([1])
//    itemsSnapshot.appendItems(items, toSection: 1)
//}
//private func createItemsDataSource() {
//    itemsDataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
//        return cell
//    })
//    itemsDataSource.apply(itemsSnapshot)
//}
