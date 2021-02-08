//
//  RestaurantCollectionViewCell.swift
//  MyRestaurants
//
//  Created by Takayuki Yamaguchi on 2021-02-04.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    var item : Movie!{
        didSet{
            updateCell()
        }
    }
    var label = UILabel()
    
    static var imagePlaceholder : UIImage = {
        let size : CGSize = .init(width: 1, height: 1)
        let img = UIGraphicsImageRenderer(size: size).image { rendererContext in
            UIColor.init(displayP3Red: 20/255, green: 20/255, blue: 20/255, alpha: 1).setFill()
            rendererContext.fill(.init(origin: .zero, size: size))
        }
        return img
    }()
        
    var imageView :UIImageView = {
       let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.layer.masksToBounds = true
        imv.layer.cornerRadius = 8
        return imv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        
        contentView.addSubview(label)
        label.centerXYin(contentView)
        
        contentView.addSubview(imageView)
        imageView.matchParent()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell() {
        label.text = item.title
        
        // Fetch image
        imageView.image = ItemCollectionViewCell.imagePlaceholder
        guard let path = item.posterURL else {return}
        let fetchURL = "https://image.tmdb.org/t/p/w400/\(path)"
        NetworkController.shared.fetchImage(urlStr: fetchURL, completionHandler: {[weak self] image in
            DispatchQueue.main.async {
                if let image = image{
                    self?.imageView.image = image
                }else{
                    // I don't know why but I have to override again. Otherwise sometimes it shows previous image.
                    self?.imageView.image = ItemCollectionViewCell.imagePlaceholder
                }
                
            }
            
        })
    }
}
