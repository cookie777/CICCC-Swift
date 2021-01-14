//
//  ViewController.swift
//  Snacks
//
//  Created by Takayuki Yamaguchi on 2021-01-12.
//

import UIKit

class UIImageViewWithName: UIImageView{
  var imageName : String?
}

class ViewController: UIViewController {
  
  
  var isClosed  : Bool      = true
  var items     : [String]  = []
  var nvLabelYConstraint : NSLayoutConstraint!
  
  var nvBarView : UIView = {
    let v = UIView()
    v.constraintHeight(equalToConstant: 400)
    v.backgroundColor = UIColor(hex: "#ddddddff")
    return v
  }()
  
  lazy var imageViewsArray : [UIImageView] = {
    var images : [UIImageView] = []
    
    images += [setImage(title: "Oreos"        )]
    images += [setImage(title: "Pizza Pockets")]
    images += [setImage(title: "Pop Tarts"    )]
    images += [setImage(title: "Popsicle"     )]
    images += [setImage(title: "Ramen"        )]
    
    return images
  }()
  
  func setImage(title : String)->UIImageViewWithName{
    let iv  = UIImageViewWithName(image: UIImage(named: title))
    let tgr = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
    iv.isUserInteractionEnabled = true
    iv.addGestureRecognizer(tgr)
    iv.imageName = title
    return iv
  }
  
  lazy var stackView : UIStackView = {
    let sv = HorizontalStackView(
      arrangedSubviews: imageViewsArray,
      distribution    : .fillProportionally
    )
    sv.constraintHeight(equalToConstant: 64)
    return sv
  }()
  
  var nvButton : UIButton = {
    let bt = UIButton()
    bt.setTitle("＋", for: .normal)
    bt.titleLabel?.font = .systemFont(ofSize: 40)
    bt.setTitleColor(.systemBlue, for: .normal)
    bt.setTitleColor(.systemGray6, for: .highlighted)
    bt.addTarget(self, action: #selector(nvBarButtonPressed(_:)), for: .touchUpInside)
    return bt
  }()
  
  var nvLabel : UILabel = {
    let lb = UILabel()
    lb.text = "Snacks"
    lb.font = .systemFont(ofSize: 32)
    return lb
  }()
  
  var tableView =  UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    
    view.backgroundColor = .systemBackground
    
    view.addSubview(nvBarView)
    nvBarView.anchors(
      topAnchor     : nil                 ,
      leadingAnchor : view.leadingAnchor  ,
      trailingAnchor: view.trailingAnchor ,
      bottomAnchor  : view.topAnchor      ,
      padding       : .init(top: nil, left: 0, bottom: -100, right: 0)
    )
    
    view.addSubview(nvButton)
    nvButton.anchors(
      topAnchor     : view.topAnchor          ,
      leadingAnchor : nil                     ,
      trailingAnchor: nvBarView.trailingAnchor,
      bottomAnchor  : nil                     ,
      padding       : .init(top: 40, left: nil, bottom: nil, right: 32)
    )
    
    
    nvBarView.addSubview(nvLabel)
    nvLabel.centerXin(nvBarView)
    nvLabelYConstraint =  nvLabel.bottomAnchor.constraint(equalTo: nvBarView.bottomAnchor, constant: -16)
    nvLabelYConstraint.identifier =  "nvLabelY"
    nvLabelYConstraint.isActive = true

    
 

    nvBarView.addSubview(stackView)
    stackView.anchors(
      topAnchor     : nil                     ,
      leadingAnchor : nvBarView.leadingAnchor ,
      trailingAnchor: nvBarView.trailingAnchor,
      bottomAnchor  : nvBarView.bottomAnchor
    )

    view.addSubview(tableView)
    tableView.anchors(
      topAnchor     : nvBarView.bottomAnchor,
      leadingAnchor : view.leadingAnchor    ,
      trailingAnchor: view.trailingAnchor   ,
      bottomAnchor  : view.bottomAnchor
    )

    
    stackView.isHidden = true
    
    
  }
  
  
  @objc func nvBarButtonPressed(_ sender: UIButton){
    
    stackView.isHidden.toggle()
    
    UIView.animate(
      withDuration          : 2,
      delay                 : 0,
      usingSpringWithDamping: 0.1,
      initialSpringVelocity : 0.1,
      options               : .curveEaseInOut,
      animations: { [weak self] in
        guard let self = self else{return}
        if self.isClosed{
          self.nvBarView.transform  = CGAffineTransform(translationX: 0, y: 100)
          self.nvButton.transform   = CGAffineTransform(rotationAngle: .pi/4)
          self.tableView.transform  = CGAffineTransform(translationX: 0, y: 100)
          self.nvLabelYConstraint.constant -= 40
          self.nvLabel.text = "Add a snack"
        }else{
          self.nvBarView.transform  = .identity
          self.nvButton.transform   = .identity
          self.tableView.transform  = .identity
          self.nvLabelYConstraint.constant += 40
          self.nvLabel.text = "Snacks"

        }
        
      },
      completion: { [weak self] _ in
        guard let self = self else{return}
        self.isClosed.toggle()
      }
    )
  }
  
  @objc func imageTapped(_ sender: UIGestureRecognizer){
    if let item = (sender.view as? UIImageViewWithName)?.imageName{
      items.append(item)
      //            tableView.reloadData()
      tableView.insertRows(at: [IndexPath(row: items.count-1, section: 0)], with: .none)
    }
  }
  
  
}

extension ViewController : UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell             = UITableViewCell()
    cell.textLabel?.text = items[indexPath.row]
    return cell
  }
  
  
}

