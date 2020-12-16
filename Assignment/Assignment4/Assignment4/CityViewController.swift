//
//  ViewController.swift
//  Assignment3
//
//  Created by Derrick Park on 2018-10-04.
//  Copyright © 2018 Derrick Park. All rights reserved.
//

import UIKit

class CityViewController: UIViewController, UINavigationControllerDelegate{
 
  
	var city: City!

	override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.delegate = self
		view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

    let cityLabel           = UILabel(frame: CGRect(
                                  x: view.bounds.width  / 2 - 150,
                                  y: view.bounds.height / 2 - 200,
                                  width : 300,
                                  height: 50
                              ))
    
    cityLabel.text          = city.emoji + city.name
    cityLabel.textAlignment = .center
    cityLabel.font          = UIFont(name: "Helvetica Neue", size: 50)
		
    
    

    let butt                = UIButton(frame: CGRect(
                                  x: view.bounds.width  / 2 - 100,
                                  y: view.bounds.height / 2 - 25,
                                  width : 200,
                                  height: 50
                              ))
    
		butt.backgroundColor    = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
		butt.setTitle("See Details...", for: .normal)
		butt.layer.cornerRadius = 10.0
		butt.addTarget(self, action: #selector(showWeatherDetails), for: .touchUpInside)
		
    
    
		view.addSubview(cityLabel)
		view.addSubview(butt)
	}
  
  //If details buttton is pressed -> push next vc + passing current "city" data
  @objc func showWeatherDetails() {
    let nextVC = DetailsViewController()
    nextVC.city = self.city
    navigationController?.navigationBar.topItem?.backButtonTitle = city.name
    navigationController?.pushViewController(nextVC, animated: true)
  }
  
  //override function for delegate
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if operation == .push {
      print("push")
      return AnimationController()
    }
    return nil
  }

}

