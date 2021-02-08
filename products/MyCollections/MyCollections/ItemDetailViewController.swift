//
//  ItemDetailViewController.swift
//  MyCollections
//
//  Created by Takayuki Yamaguchi on 2021-02-06.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    var item : Movie?
    var imageView :UIImageView = {
       let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.heightAnchor.constraint(equalTo: imv.widthAnchor, multiplier: 3/2).isActive = true
        imv.layer.masksToBounds = true
        imv.layer.cornerRadius = 8
        return imv
    }()
    
    
    let titleLabel : UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .systemFont(ofSize: 32, weight: .black)
        return lb
    }()
    let tagsLabel : UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .systemFont(ofSize: 16, weight: .thin)
        return lb
    }()
    let ratingLabel : UILabel = {
        let lb = UILabel()
        lb.textColor =  UIColor.systemPink.withAlphaComponent(0.9)
        return lb
    }()
    lazy var  infoStackView : VerticalStackView = {
        let sv = VerticalStackView(arrangedSubviews: [titleLabel, tagsLabel, ratingLabel])
        sv.setCustomSpacing(0, after: titleLabel)
        sv.setCustomSpacing(16, after: tagsLabel)
        return sv
    }()
    
    
    lazy var mainStackView =  VerticalStackView(arrangedSubviews: [imageView, infoStackView], spacing: 16)
    


    
    init(item: Movie, image: UIImage?) {
        self.item = item
        self.imageView.image = image
        
        self.titleLabel.text = item.title
        self.ratingLabel.text = "\(item.rating)/10 (\(item.reviewCount))"
        
        let genreNames = item.genre.reduce("") { (str, genreId) -> String in
            if let genreName = movieGenre[genreId]{
                return "\(str)\(genreName), "
            }
            return str
        }
        self.tagsLabel.text = "\(genreNames)"
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .clear
        
        view.addSubview(mainStackView)
        mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true

        mainStackView.centerXYin(view)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // This can detect touches view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Let user to dismiss when tapping out side (view)
        if touches.first?.view == view{
            dismiss(animated: true, completion: nil)
        }
    }

}
