//
//  SuperViewController.swift
//  Assignment3
//
//  Created by Takayuki Yamaguchi on 2020-12-11.
//

/*
 Super view cotroller for each view Controller.
 This vc is not used directly but used as parent view.
 */

import UIKit

class SuperViewController: UIViewController {
  
  
  enum Location : String {
    case doorway    = "Doorway"
    case coatRoom   = "Coat room"
    case library    = "Library"
    case diningRoom = "Dining room"
    case stairsUp   = "Staris up"
  }
  
  var currentLocation : Location = .doorway
  var destinations : [Location] = []
  
  var fetchImgaeURL = {(l: Location) -> String in
    switch l{
    case .doorway:
      return "doorway"
    case .coatRoom:
      return "coat_room"
    case .library:
      return "library"
    case .diningRoom:
      return "dining_room"
    case .stairsUp:
      return "stairs_up"
    }
  }
  
  var fetchViewController = {(l: Location) -> SuperViewController in
    switch l{
    case .coatRoom:
      return CoatRoomViewController()
    case .doorway:
      return DoorwayViewController()
    case .library:
      return LibraryViewController()
    case .diningRoom:
      return DiningRoomViewController()
    case .stairsUp:
      return StarisUpViewController()
    }
  }
  
  
  lazy var imageView : UIImageView = {
    let image = UIImage(named: fetchImgaeURL(currentLocation))
    let iv =  UIImageView(image: image)
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  
  
  lazy var buttons : [UIButton]  = {
    var bts: [UIButton] = []
    for d in destinations{
      let bt = UIButton()
      bt.translatesAutoresizingMaskIntoConstraints = false
      bt.setTitle(d.rawValue, for: .normal)
      bt.backgroundColor  = .black
      bt.addTarget(self, action: #selector(btPressed), for: .touchUpInside)
      bts += [bt]
    }
    return bts
  }()
  
  
  lazy var buttonStackView : UIStackView = {
    let sv = UIStackView(arrangedSubviews: buttons)
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.axis = .vertical
    sv.alignment = .center

    sv.isLayoutMarginsRelativeArrangement = true
    sv.distribution = .equalSpacing
    sv.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    return sv
  }()
  
  
  lazy var mainStackView : UIStackView = {
    let sv = UIStackView(arrangedSubviews: [imageView, buttonStackView])
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.axis = .vertical
    sv.alignment = .center

    sv.isLayoutMarginsRelativeArrangement = true
    sv.distribution = .equalSpacing
    sv.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    return sv
  }()
  
  
  
  init(currentLocation: Location, nextDestinations : [Location]) {
    super.init(nibName: nil, bundle: nil)
    
    self.currentLocation = currentLocation
    destinations = nextDestinations
    
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .cyan
    setLayout()
  }
    
  
  func setLayout() {
    view.addSubview(mainStackView)
    NSLayoutConstraint.activate([
      mainStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
      imageView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.6),
      buttonStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.3),
    ])
  }
  
 

  @objc func btPressed(sender: UIButton!){
    guard let nextStr = sender.titleLabel?.text else{
      return
    }
    guard let nextEnum = Location(rawValue: nextStr) else {
      return
    }
    let nextVC = fetchViewController(nextEnum)

    navigationController?.pushViewController(nextVC, animated: true)
  }

}
