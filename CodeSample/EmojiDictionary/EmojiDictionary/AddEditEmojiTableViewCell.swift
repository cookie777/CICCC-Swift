//
//  AddEditEmojiTableViewCell.swift
//  EmojiDictionary
//
//  Created by Derrick Park on 2021-01-06.
//

import UIKit

class AddEditEmojiTableViewCell: UITableViewCell {
  
  let textField: UITextField = {
    let tf = UITextField()
    tf.borderStyle = .roundedRect
    return tf
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(textField)
    textField.matchParent(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
