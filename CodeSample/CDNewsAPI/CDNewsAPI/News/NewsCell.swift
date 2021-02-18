//
//  NewsCell.swift
//  NewsAPI
//
//  Created by Derrick Park on 5/24/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
  static let reuseIdentifier = "NewsCell"
  
  private let thumbnailView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.constraintWidth(equalToConstant: 128, heightEqualToConstant: 128)
    return iv
  }()
  
  private let titleLabel: UILabel = {
    let lb = UILabel()
    lb.font = .preferredFont(forTextStyle: .headline)
    lb.numberOfLines = 0
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.setContentHuggingPriority(.defaultHigh, for: .vertical)
    return lb
  }()
  
  private let contentButton: UIButton = {
    let btn = UIButton(type: .roundedRect)
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitle("View more...", for: .normal)
    btn.setContentHuggingPriority(.required, for: .vertical)
    return btn
  }()
  
  var article: Article? { didSet { updateUI() } }
  
  var viewMorePressed: ((_ url: URL) -> ())?
  
  private func updateUI() {
    titleLabel.text = article?.title
    if let urlStr = article!.urlToImage, let thumbnailURL = URL(string: urlStr) {
      thumbnailView.sd_setImage(with: thumbnailURL)
    } else {
      thumbnailView.image = nil
    }
    contentButton.addTarget(self, action: #selector(viewMoreContent(_:)), for: .touchUpInside)
  }
  
  @objc func viewMoreContent(_ sender: UIButton) {
    if let url = article?.url {
      viewMorePressed?(url)
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    let vStackView = VerticalStackView(arrangedSubviews: [titleLabel, contentButton], spacing: 8, alignment: .firstBaseline, distribution: .fill)
    let hStackView = HorizontalStackView(arrangedSubviews: [thumbnailView, vStackView], spacing: 16, alignment: .center, distribution: .fill)
    contentView.addSubview(hStackView)
    
    hStackView.matchParent(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
