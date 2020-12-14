//
//  SuperViewController.swift
//  Assignment3
//
//  Created by Takayuki Yamaguchi on 2020-12-11.
//



/*
 # Super ViewCotroller of each view Controller.
 
 ## Overview
 - By passing `currentLocation` and `nextDestinations` parameters,
  this ViewCotroller creates
  - image view of current location
  - buttons(link) which leads to next destinations

 ## Note
 - This ViewCotroller is not used directly.
 - Each of this child ViewCotroller is used instead for instanciating.
 - Each location(room) is named by `Location` enum.
 - Each ViewCotroller is stored in Navigation controller
 */

import UIKit

class SuperViewController: UIViewController {
  
  
  /*
   # Instance variables ---------------------------------------------
   */
  
  
  /*
   # Store the current location and next locations.
   - These variables are initilized again in init()
   
   ## ex)
   At StarisUpViewController,
    `super.init(currentLocation: .stairsUp , nextDestinations: [.bedroom, .bathroom])`
   is called and each variables are initilized as
   
     currentLocation ->  .stairsUp
     destinations    -> [.bedroom, .bathroom]
     
   */
  var currentLocation : Location    = .doorway
  var destinations    : [Location]  = []
  
  
  /*
   # Create imageview.
   - By using lazy, this view will be called after imageURL is fetched.
   
   ## order)
   1. `currentLocation` is initilazed at init()
   2. `setLayout()` is called in `ViewDidload()`
   3. `imageView` in `setLayout()` is finally called.
   */
  lazy var imageView : UIImageView = {
    let image = UIImage(named: LocationDetails.imgaeURL(currentLocation))
    
    let iv    = UIImageView(image: image)
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  
  /*
   # Create array of UIButton.
   - The number of button is determinded by `destinations`.
   - Set title by using rawvalue of `Location` enum.
   
   ## ex)
   If `destinations` is `[.bedroom, .bathroom]`,
   it creates two buttons with title "Bedroom" and "Bathroom", and
   stores them into array `buttons`.
   */
  lazy var buttons : [UIButton]  = {
    var bts: [UIButton] = []
    
    for d in destinations{
      let bt = UIButton()
      bt.translatesAutoresizingMaskIntoConstraints = false
      bt.setTitle     (d.rawValue , for: .normal)
      bt.setTitleColor(.systemGray, for: .normal)
      bt.setTitleColor(.purple    , for: .highlighted)
      bt.addTarget    (self       , action: #selector(btPressed), for: .touchUpInside)
      bt.backgroundColor  = .white
      
      bts += [bt]
    }
    return bts
  }()
  
  /*
   # Create Stackview of buttons.
    - `buttons`
   is stored as subviews.
   */
  lazy var buttonStackView : UIStackView = {
    let sv = UIStackView(arrangedSubviews: buttons)
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.axis         = .vertical
    sv.alignment    = .center
    sv.distribution = .equalSpacing

    sv.isLayoutMarginsRelativeArrangement = true
    sv.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    return sv
  }()
  
  
  /*
   # Create Stackview which is used for main view.
   - `imageView`
   - `buttonStackView`
   are stored as subviews.
   */
  lazy var mainStackView : UIStackView = {
    let sv = UIStackView(arrangedSubviews: [imageView, buttonStackView])
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.backgroundColor = .white
    sv.axis            = .vertical
    sv.alignment       = .center
    sv.distribution    = .equalSpacing
    
    sv.isLayoutMarginsRelativeArrangement = true
    sv.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    return sv
  }()
  
  
  
  

  
  /*
   # Initilization ------------------------------------------------------------
  - Store the current location and next locations.
  
  ## ex)
  If you pass `(currentLocation: .stairsUp , nextDestinations: [.bedroom, .bathroom])` , it will store
    currentLocation ->  .stairsUp
    destinations    -> [.bedroom, .bathroom]
   */
  init(currentLocation: Location, nextDestinations : [Location]) {
    super.init(nibName: nil, bundle: nil)
    
    self.currentLocation  = currentLocation
    destinations          = nextDestinations
    
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  
  
  /*
   # Functions -------------------------------------------------------------
   */
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    setLayout()
  }
  

  /*
   # Set navigation
   
   - Set title with current location's(enum) raw value
   - If the current location is not rootView(==doorway),
     set the home botton.
   - Home botton leads users to go back to rootView.
   */
  func setNavigation(){
    self.navigationItem.title = currentLocation.rawValue
    if currentLocation != .doorway {
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(
        title : Location.doorway.rawValue,
        style : .plain,
        target: self,
        action: #selector(homeBtPressed)
      )
    }
  }
  
  /*
   # Set layout (main stack view)
   */
  func setLayout() {
    view.addSubview(mainStackView)
    NSLayoutConstraint.activate([
      mainStackView.centerXAnchor.constraint  (equalTo: view.safeAreaLayoutGuide.centerXAnchor),
      mainStackView.topAnchor.constraint      (equalTo: view.safeAreaLayoutGuide.topAnchor,    constant: 0),
      mainStackView.bottomAnchor.constraint   (equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
      imageView.heightAnchor.constraint       (equalTo: mainStackView.heightAnchor, multiplier: 0.6),
      buttonStackView.heightAnchor.constraint (equalTo: mainStackView.heightAnchor, multiplier: 0.3),
    ])
  }
  
  /*
   # Set home botton action if pressed.
   - It leads to root view (pop all vc in navigation controller except root view)
   - Then, reset the color of button in root view.
   */
  @objc func homeBtPressed(sender: UIBarButtonItem!){
    navigationController?.popToRootViewController(animated: true)
    
    if let rootVC = navigationController?.topViewController as? SuperViewController{
      for bt in rootVC.buttons{
        bt.setTitleColor(.systemGray, for: .normal)
      }
    }
  }
  
  /*
   # Set button (which leads to next destination)
   
   If the button is pressed, it will do as below
   - Create the next ViewController (by getting title and it's enum from sender
   - Move to the next ViewController (by pushing it to the navigation Controller
   - Change the color of button into purple, so that the user can know it they visit already.
   */
  @objc func btPressed(sender: UIButton!){
    
    guard let nextStr   = sender.titleLabel?.text else{
      return
    }
    guard let nextEnum  = Location(rawValue: nextStr) else {
      return
    }
    sender.setTitleColor(.purple, for: .normal)
    let nextVC = LocationDetails.nextViewController(nextEnum)

    navigationController?.pushViewController(nextVC, animated: true)
  }

}



/*
 note
 question
 - init why required
 - instace -> init -> viewdid?
 
 todo
 - comment
 
 */
