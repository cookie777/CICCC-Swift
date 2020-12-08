//
//  ViewController.swift
//  AutoLayoutStarter
//
//  Created by Derrick Park on 2019-04-17.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let mainView: UIView = {
    let main = UIView()
    main.translatesAutoresizingMaskIntoConstraints = false
    main.backgroundColor = .green
    return main
  }() // immediately invoked closure / function
  
  let squareButton: UIButton = {
    
    let butt = UIButton(type: .system)
    butt.setTitle("Square", for: .normal)
    butt.translatesAutoresizingMaskIntoConstraints = false
    butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    butt.addTarget(self, action: #selector(squareTapped), for: .touchUpInside)
    return butt
  }()
  
  let portraitButton: UIButton = {
    let butt = UIButton(type: .system)
    butt.setTitle("Portrait", for: .normal)
    butt.translatesAutoresizingMaskIntoConstraints = false
    butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    butt.addTarget(self, action: #selector(portraitTapped), for: .touchUpInside)
    return butt
  }()
  
  let landScapeButton: UIButton = {
    let butt = UIButton(type: .system)
    butt.setTitle("Landscape", for: .normal)
    butt.translatesAutoresizingMaskIntoConstraints = false
    butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    butt.addTarget(self, action: #selector(landscapeTapped), for: .touchUpInside)
    return butt
  }()
  
  
  
  
  //Set the purpleRectangleView
  let purpleRectangleView: UIView = {
    let rec = UIView()
    rec.translatesAutoresizingMaskIntoConstraints = false
    rec.backgroundColor = .purple
    return rec
  }()
  
  //Set the blueSqures and StackView
  let blueSquresStackView: UIStackView = {
    // Initilize squares by using for loop
    var sqes:[UIView] = []
    for _ in 0...2 {
        let sq = UIView()
        sq.translatesAutoresizingMaskIntoConstraints = false
        sq.backgroundColor = .blue
        sqes += [sq]
    }
    // Initilize stackView
    let rec = UIStackView(arrangedSubviews: sqes)
    rec.translatesAutoresizingMaskIntoConstraints = false
    rec.axis = .vertical
    rec.alignment = .center
    rec.distribution = .equalSpacing
    return rec
  }()
  
  //Set the redRectangle and StackView
  let redRectangleStackView: UIStackView = { (recWidth: CGFloat) in
    // Initilize the subviews
    let l = UIView()
    l.backgroundColor = .orange
    l.translatesAutoresizingMaskIntoConstraints = false
    
    let r = UIView()
    r.backgroundColor = .orange
    r.translatesAutoresizingMaskIntoConstraints = false

    // Initilize the stackview and add subviews
    let rec = UIStackView(arrangedSubviews: [l,r])
    
    rec.translatesAutoresizingMaskIntoConstraints = false
    // Set marign of stack view
    rec.spacing = recWidth/4
    rec.directionalLayoutMargins = NSDirectionalEdgeInsets(top: recWidth/4, leading: recWidth/4, bottom: recWidth/4, trailing: recWidth/4)
    rec.backgroundColor = .red
    rec.axis = .horizontal
    rec.distribution = .equalSpacing
    // This is required when you want to set margin in stackview!
    rec.isLayoutMarginsRelativeArrangement = true
    return rec
  }(64)
  


  var widthAnchor: NSLayoutConstraint?
  var heightAnchor: NSLayoutConstraint?
  
  let recWidth: CGFloat = 64
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(mainView)
    setupLayout()
  }
    
    

  fileprivate func setupLayout() {
    /*
     Set the main view (green)
     */
    //set constrains
    mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    widthAnchor = mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7, constant: 0)
    widthAnchor?.isActive = true
    heightAnchor = mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7, constant: 0)
    heightAnchor?.isActive = true
    
    
    
    
    
    
    /*
     Set the purple rectagle
     */
    view.addSubview(purpleRectangleView)
    //set constrains
    NSLayoutConstraint.activate([
      purpleRectangleView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -recWidth/2),
      purpleRectangleView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -recWidth/2),
      purpleRectangleView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6),
      purpleRectangleView.heightAnchor.constraint(equalToConstant: recWidth)
    ])
    
    
    
    
    /*
     Set the blue squares
     */

    view.addSubview(blueSquresStackView)
    // Set constrains of subview(squres)
    for i in 0...2{
        NSLayoutConstraint.activate([
            blueSquresStackView.arrangedSubviews[i].widthAnchor.constraint(equalToConstant: recWidth),
            blueSquresStackView.arrangedSubviews[i].heightAnchor.constraint(equalToConstant: recWidth)
        ])
    }
    
    // Set constrains of Stackview
    NSLayoutConstraint.activate([
        blueSquresStackView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.7),
        blueSquresStackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        blueSquresStackView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
        blueSquresStackView.widthAnchor.constraint(equalToConstant: recWidth),
    ])
    
    
    
    
    
    
    /*
     Set the red squares
     */
    view.addSubview(redRectangleStackView)
    // Set constrains of subviews
    NSLayoutConstraint.activate([
      redRectangleStackView.arrangedSubviews[0].widthAnchor.constraint(equalToConstant: recWidth*1.5),
      redRectangleStackView.arrangedSubviews[1].widthAnchor.constraint(equalToConstant: recWidth),
    ])
    
    // Set constrains of stackview
    NSLayoutConstraint.activate([
      redRectangleStackView.heightAnchor.constraint(equalToConstant: recWidth),
      redRectangleStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: recWidth/2),
      redRectangleStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -recWidth/2)
    ])

    
    
    

    /*
     Set the switching bottons (squareButton, portraitButton, landScapeButton)
     */
    let buttStackView = UIStackView(arrangedSubviews: [
      squareButton, portraitButton, landScapeButton])
    buttStackView.translatesAutoresizingMaskIntoConstraints = false
    buttStackView.axis = .horizontal
    buttStackView.alignment = .center
    buttStackView.distribution = .fillEqually
    
    view.addSubview(buttStackView)
    NSLayoutConstraint.activate([
      buttStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      buttStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      buttStackView.heightAnchor.constraint(equalToConstant: 50),
      buttStackView.widthAnchor.constraint(equalTo: view.widthAnchor)
      ])
    
    
    
  }
    

  @objc private func squareTapped() {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.widthAnchor?.isActive = false
      self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
      self.widthAnchor?.isActive = true
      
      self.heightAnchor?.isActive = false
      self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
      self.heightAnchor?.isActive = true
      self.view.layoutIfNeeded()
    }
  }
  
  @objc private func portraitTapped() {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.widthAnchor?.isActive = false
      self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7)
      self.widthAnchor?.isActive = true
      
      self.heightAnchor?.isActive = false
      self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7)
      self.heightAnchor?.isActive = true
      self.view.layoutIfNeeded()
    }
    
  }
  
  @objc private func landscapeTapped() {
    view.layoutIfNeeded()
    UIView.animate(withDuration: 2.0) {
      self.widthAnchor?.isActive = false
      self.widthAnchor? = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95)
      self.widthAnchor?.isActive = true
      
      self.heightAnchor?.isActive = false
      self.heightAnchor? = self.mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4)
      self.heightAnchor?.isActive = true
      self.view.layoutIfNeeded()
    }
  }
}


