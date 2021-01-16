//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by Takayuki Yamaguchi on 2021-01-15.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
  
  
  var imageView : UIImageView = {
    let img = UIImage(systemName: "photo.on.rectangle")
    let imgV = UIImageView(image: img)
    imgV.contentMode = .scaleAspectFit
    return imgV
  }()
  
  var nameLabel : UILabel = {
    let lb = UILabel()
    lb.text = "item Name"
    lb.font = .systemFont(ofSize: 16)
    return lb
  }()
  var priceLabel : UILabel = {
    let lb = UILabel()
    lb.text = "$ price"
    lb.font = .systemFont(ofSize: 16)
    return lb
  }()
  lazy var namePriceStackView =
    HorizontalStackView(arrangedSubviews: [nameLabel, priceLabel],alignment: .fill,distribution: .equalSpacing)
  
  var detailTextLabel : UILabel = {
    let lb = UILabel()
    lb.text = "detailText"
    lb.font = .systemFont(ofSize: 12)
    lb.tintColor = .systemGray6
    return lb
  }()
  
  lazy var itemStackView = VerticalStackView(arrangedSubviews: [
    imageView, namePriceStackView,detailTextLabel
  ])
  
  var addToOrderButton: UIButton = {
    let bt = UIButton()
    bt.heightAnchor.constraint(equalToConstant: 44).isActive = true
    bt.setTitle("Add to Order", for: .normal)
    bt.backgroundColor = .systemBlue
    bt.layer.cornerRadius = 5.0
    bt.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
    return bt
  }()
  
  
  
  let menuItem: MenuItem
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    setLayout()
    updateUI()
  }
  
  init(menuItem: MenuItem) {
    self.menuItem = menuItem
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setLayout(){
    
    view.addSubview(itemStackView)
    imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
    itemStackView.anchors(
      topAnchor: view.safeAreaLayoutGuide.topAnchor,
      leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor,
      trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor,
      bottomAnchor: nil,
      padding: .init(top: 15, left: 15, right: 15, bottom: nil)
    )
    
    view.addSubview(addToOrderButton)
    addToOrderButton.anchors(
      topAnchor: nil,
      leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor,
      trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor,
      bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
      padding: .init(top: nil, left: 15, right: 15, bottom: 15)
    )
  }
  
  
  func updateUI() {
    nameLabel.text = menuItem.name
    priceLabel.text = MenuItem.priceFormatter.string(from: NSNumber(value: menuItem.price))
    detailTextLabel.text = menuItem.detailText
    MenuController.shared.fetchImage(url: menuItem.imageURL) { (img) in
      guard let img = img else{return}
      DispatchQueue.main.async {
        self.imageView.image = img
      }
    }
  }

  @objc func orderButtonTapped(){
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 0.7,
      initialSpringVelocity: 0.1,
      options: [.curveEaseInOut],
      animations: {
        self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
        self.addToOrderButton.transform = CGAffineTransform(scaleX: 1, y: 1)
      },
      completion: nil
    )
    
    // add selected menuItem to shared menuitems
    MenuController.shared.order.menuItems.append(menuItem)
  }
  
}

