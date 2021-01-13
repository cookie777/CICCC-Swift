//
//  AddEditEmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Derrick Park on 2021-01-06.
//

import UIKit

protocol AddEditEmojiTVCDelegate: class {
  func add(_ emoji: Emoji)
  func edit(_ emoji: Emoji)
}

class AddEditEmojiTableViewController: UITableViewController {
  
  let headers = ["Symbol", "Name", "Description", "Usage"]
  lazy var saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveEmoji))
  
  let symbolCell = AddEditEmojiTableViewCell()
  let nameCell = AddEditEmojiTableViewCell()
  let descriptionCell = AddEditEmojiTableViewCell()
  let usageCell = AddEditEmojiTableViewCell()
  
  weak var delegate: AddEditEmojiTVCDelegate?
  
  var emoji: Emoji?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    if emoji == nil {
      title = "Add Emoji"
    } else {
      title = "Edit Emoji"
      symbolCell.textField.text = emoji?.symbol
      nameCell.textField.text = emoji?.name
      descriptionCell.textField.text = emoji?.description
      usageCell.textField.text = emoji?.usage
    }
    
    // cancel button
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissViewController))
    // save button
    navigationItem.rightBarButtonItem = saveButton
    
    // textfields add target action
    symbolCell.textField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
    nameCell.textField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
    descriptionCell.textField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
    usageCell.textField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
    
    updateSaveButtonState()
  }
  
  @objc func textEditingChanged(_ sender: UITextField) {
    updateSaveButtonState()
  }
  
  @objc func dismissViewController() {
    dismiss(animated: true)
  }
  
  @objc func saveEmoji() {
    // 1. create a new Emoji
    // 2. pass the Emoji back to EmojiTableViewController & append to the emojis array
    // 3. update table view
    let newEmoji = Emoji(symbol: symbolCell.textField.text!, name: nameCell.textField.text!, description: descriptionCell.textField.text!, usage: usageCell.textField.text!)
    if emoji == nil {
      delegate?.add(newEmoji)
    } else {
      delegate?.edit(newEmoji)
    }
    dismiss(animated: true, completion: nil)
  }
  
  private func updateSaveButtonState() {
    let nameText = nameCell.textField.text ?? ""
    let descriptionText = descriptionCell.textField.text ?? ""
    let usageText = usageCell.textField.text ?? ""
    saveButton.isEnabled = containsSingleEmoji(symbolCell.textField) && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
  }
  
  private func containsSingleEmoji(_ textField: UITextField) -> Bool {
    guard let text = textField.text, text.count == 1 else { return false }
    return text.unicodeScalars.first?.properties.isEmojiPresentation ?? false
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath {
    case [0, 0]:
      return symbolCell
    case [1, 0]:
      return nameCell
    case [2, 0]:
      return descriptionCell
    case [3, 0]:
      return usageCell
    default:
      fatalError("Invalid number of cells")
    }
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return headers[section]
  }
  
}
