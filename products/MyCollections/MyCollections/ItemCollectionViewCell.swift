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
    
    var imagePlaceholder : UIImage = {
        let img = UIImage(systemName: "photo" ,withConfiguration: UIImage.SymbolConfiguration.init(weight: .thin))?.withTintColor(.systemGray6, renderingMode: .alwaysOriginal)
        return img!
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
        imageView.image = imagePlaceholder
        guard let path = item.posterURL else {return}
        let fetchURL = "https://image.tmdb.org/t/p/w400/\(path)"
        NetworkController.shared.fetchImage(urlStr: fetchURL, completionHandler: {[weak self] image in

            guard let image = image else {return}
            
            DispatchQueue.main.async {
                self?.imageView.image = image
                
            }
            
        })
    }
}
