//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Takayuki Yamaguchi on 2021-01-15.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
  
  var confirmationLabel : UILabel = {
    let lb = UILabel()
    lb.lineBreakMode = .byWordWrapping
    lb.numberOfLines = 0
    lb.textAlignment = .center
    return lb
  }()
  var dismissButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("Dismiss", for: .normal)
    bt.setTitleColor(.systemBlue, for: .normal)
    bt.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
    return bt
  }()
  lazy var stackView = VerticalStackView(arrangedSubviews: [confirmationLabel, dismissButton], spacing: 16, distribution: .fill)
  
  let minutesToPrepare: Int!
  
  init(minutesToPrepare: Int) {
    self.minutesToPrepare = minutesToPrepare
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .systemBackground
    
    view.addSubview(stackView)
    stackView.centerXYinSafeArea(view)
    stackView.matchParentWidth(padding: .init(top: nil, left: 16, right: 16, bottom: nil))
    
    confirmationLabel.text =
      "Thank you for your order! Your wait time is approximately \(minutesToPrepare) minutes."
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @objc func dismissTapped(){
    dismiss(animated: true, completion: {
      MenuController.shared.order.menuItems.removeAll()
    })
  }
  
  
}
