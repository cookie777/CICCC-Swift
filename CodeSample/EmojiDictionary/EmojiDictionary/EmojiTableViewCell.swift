//
//  EmojiTableViewCell.swift
//  EmojiDictionary
//
//  Created by Derrick Park on 2021-01-06.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
  
  let emojiSymbolLabel: UILabel = {
    let lb = UILabel()
    lb.setContentHuggingPriority(.required, for: .horizontal)
    return lb
  }()
  
  let emojiNameLabel: UILabel = {
    let lb = UILabel()
    lb.font = .boldSystemFont(ofSize: 20)
    return lb
  }()
 
  let emojiDescriptionLabel: UILabel =  {
    let lb = UILabel()
    lb.numberOfLines = 0
    return lb
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    let vStackView = VerticalStackView(arrangedSubviews: [
      emojiNameLabel,
      emojiDescriptionLabel
    ], spacing: 0, alignment: .fill,distribution: .fill)
    
    let hStackView = HorizontalStackView(arrangedSubviews: [
      emojiSymbolLabel, vStackView
    ], spacing: 16, alignment: .fill, distribution: .fill)
    
    contentView.addSubview(hStackView)
    hStackView.matchParent(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func update(with emoji: Emoji) {
    emojiSymbolLabel.text = emoji.symbol
    emojiNameLabel.text = emoji.name
    emojiDescriptionLabel.text = emoji.description
  }
}
