//
//  ViewController.swift
//  AutoLayoutStarter
//
//  Created by Derrick Park on 2019-04-17.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
//    Set main view object as computed variable
  let mainView: UIView = {
    let main = UIView()
    // important when setting contraints programmatically
    main.translatesAutoresizingMaskIntoConstraints = false
    main.backgroundColor = .green
    return main
  }()
    
    
  
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

  var widthAnchor: NSLayoutConstraint?
  var heightAnchor: NSLayoutConstraint?
  
  let rectagleWidth: CGFloat = 64
    
  
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
    //Initilize
    let purpleRectangle = UIView()
    purpleRectangle.translatesAutoresizingMaskIntoConstraints = false
    purpleRectangle.backgroundColor = .purple
    view.addSubview(purpleRectangle)
    
    print(rectagleWidth/2)
    //set constrains
    NSLayoutConstraint.activate([
      purpleRectangle.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -rectagleWidth/2),
      purpleRectangle.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -rectagleWidth/2),
      purpleRectangle.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6),
      purpleRectangle.heightAnchor.constraint(equalToConstant: rectagleWidth)
    ])
    
    
    
    /*
     Set the blue squares
     */
    // Initilize squares by using for loop
    var blueSquares:[UIView] = []
    for _ in 0...2 {
        let sq = UIView()
        sq.translatesAutoresizingMaskIntoConstraints = false
        sq.backgroundColor = .blue
        blueSquares += [sq]
    }
    
    // Initilize stackView
    let blueSquresStackView = UIStackView(arrangedSubviews: blueSquares)
    blueSquresStackView.translatesAutoresizingMaskIntoConstraints = false
    blueSquresStackView.axis = .vertical
    blueSquresStackView.alignment = .center
    blueSquresStackView.distribution = .equalSpacing
    view.addSubview(blueSquresStackView)


    // Set constrains of subview(squres)
    for i in 0...2{
        NSLayoutConstraint.activate([
            blueSquresStackView.arrangedSubviews[i].widthAnchor.constraint(equalToConstant: rectagleWidth),
            blueSquresStackView.arrangedSubviews[i].heightAnchor.constraint(equalToConstant: rectagleWidth)
        ])
    }
    
    NSLayoutConstraint.activate([
        blueSquresStackView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.7),
        blueSquresStackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        blueSquresStackView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
        blueSquresStackView.widthAnchor.constraint(equalToConstant: rectagleWidth),
    ])
    
    
    
    
    /*
     Set the red squares
     */
    
    // Initilize the subviews
    let leftRectangle = UIView()
    leftRectangle.backgroundColor = .orange
    leftRectangle.translatesAutoresizingMaskIntoConstraints = false
    
    let rightRectangle = UIView()
    rightRectangle.backgroundColor = .orange
    rightRectangle.translatesAutoresizingMaskIntoConstraints = false

    // Initilize the stackview and add subviews
    let redRectangleStackView = UIStackView(arrangedSubviews: [leftRectangle,rightRectangle])
    redRectangleStackView.translatesAutoresizingMaskIntoConstraints = false
    redRectangleStackView.backgroundColor = .red
    
    redRectangleStackView.axis = .horizontal
    redRectangleStackView.distribution = .equalSpacing
    redRectangleStackView.isLayoutMarginsRelativeArrangement = true
//
    
    view.addSubview(redRectangleStackView)
    // Set constrains of subviews
    NSLayoutConstraint.activate([
      leftRectangle.topAnchor.constraint(equalTo: redRectangleStackView.topAnchor, constant: rectagleWidth/4),
      leftRectangle.leadingAnchor.constraint(equalTo: redRectangleStackView.leadingAnchor, constant: rectagleWidth/4),
      leftRectangle.bottomAnchor.constraint(equalTo: redRectangleStackView.bottomAnchor, constant: -rectagleWidth/4),
      leftRectangle.widthAnchor.constraint(equalTo: redRectangleStackView.widthAnchor, multiplier: 0.6),
      
      rightRectangle.leadingAnchor.constraint(equalTo: leftRectangle.trailingAnchor, constant: rectagleWidth/4),
      rightRectangle.topAnchor.constraint(equalTo: redRectangleStackView.topAnchor, constant: rectagleWidth/4),
      rightRectangle.bottomAnchor.constraint(equalTo: redRectangleStackView.bottomAnchor, constant: -rectagleWidth/4),
      rightRectangle.trailingAnchor.constraint(equalTo: redRectangleStackView.trailingAnchor, constant: -rectagleWidth/4)
    ])
    
    // Set constrains of stackview
    NSLayoutConstraint.activate([
      redRectangleStackView.widthAnchor.constraint(equalToConstant: rectagleWidth*4),
      redRectangleStackView.heightAnchor.constraint(equalToConstant: rectagleWidth),
      redRectangleStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: rectagleWidth/2),
      redRectangleStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -rectagleWidth/2)
    ])

    
    
    
    
    

    


    
//    Set the switching bottons (squareButton, portraitButton, landScapeButton)
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


/*
 note
 
 - xxxview.bounds.widht will be 0.0 at view did load (need .layoutIfNeeded())
 - you can integrate .isActivate = true by NSLayoutConstraint.activate([])
  - or you can make extention https://www.avanderlee.com/swift/auto-layout-programmatically/
 - all contrains setting + "including subview of stack view" must be done after view.addSubview()
 - only heightAnchor, width Anchor has multiplier (not in top or bottom)
 - Double and CGFloat is different
 - the point is , set the minimun constrains -> try to save constrains so that there will be no conflicts
 
 Q
 - in computed variables, what is () of {}() ?
 - isLayoutMarginsRelativeArrangement = true?
 */
