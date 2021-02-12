//
//  HabitDetailViewController.swift
//  Habits
//
//  Created by Takayuki Yamaguchi on 2021-02-10.
//

import UIKit

class HabitDetailViewController: UIViewController {
  
  let nameLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = UIFont.systemFont(ofSize: 32, weight: .regular)
    lb.textAlignment = .left
    lb.numberOfLines = 1
    return lb
  }()
  let categoryLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = UIFont.systemFont(ofSize: 24, weight: .regular)
    lb.textAlignment = .right
    lb.numberOfLines = 1
    return lb
  }()
  lazy var nameCategoryWrapper = HorizontalStackView(
    arrangedSubviews:[nameLabel, categoryLabel],
    spacing: 12,
    alignment: .firstBaseline,
    distribution: .equalSpacing
  )
  
  let infoLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = UIFont.systemFont(ofSize: 24, weight: .regular)
    lb.textAlignment = .left
    lb.numberOfLines = 0
    return lb
  }()
  lazy var allWrapper = VerticalStackView(
    arrangedSubviews: [nameCategoryWrapper, infoLabel],
    spacing: 16,
    alignment: .fill,
    distribution: .fill
  )
  
  let collectionView : UICollectionView = UICollectionView()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(allWrapper)
    let sa = view.safeAreaLayoutGuide
    allWrapper.anchors(
      topAnchor: sa.topAnchor,
      leadingAnchor: sa.leadingAnchor,
      trailingAnchor: sa.trailingAnchor,
      bottomAnchor: nil,
      padding: .init(top: 20, left: 12, bottom: 0, right: 12)
    )
    
    view.addSubview(collectionView)
    collectionView.anchors(
      topAnchor: allWrapper.bottomAnchor,
      leadingAnchor: sa.leadingAnchor,
      trailingAnchor: sa.trailingAnchor,
      bottomAnchor: sa.bottomAnchor,
      padding: .init(top: 20, left: 0, bottom: 0, right: 0)
    )
    
  }

}
