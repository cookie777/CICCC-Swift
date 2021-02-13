//
//  ViewController.swift
//  UserDefaults
//
//  Created by Derrick Park on 2021-02-12.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

  @IBOutlet var bluetoothSwitch: UISwitch!
  @IBOutlet var tableView: UITableView!
  var numbers: [Int] = []
  var number = 0
  let defaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let defaults = UserDefaults.standard
    let isBluetoothOn = defaults.bool(forKey: Constants.UserDefaults.bluetoothSwitch)
    bluetoothSwitch.isOn = isBluetoothOn
    
    if let nums = defaults.array(forKey: Constants.UserDefaults.numberList) {
      numbers = nums as! [Int]
    }
    
    tableView.dataSource = self
  }

  @IBAction func saveSwitchState(_ sender: UISwitch) {
    // 1. get the userDefaults object
    let defaults = UserDefaults.standard
    // 2. save the state
    defaults.set(sender.isOn, forKey: Constants.UserDefaults.bluetoothSwitch)
  }
  
  @IBAction func addButtonTapped(_ sender: UIButton) {
    number += 1
    numbers.append(number)
    tableView.insertRows(at: [IndexPath(row: numbers.count - 1, section: 0)], with: .automatic)
    defaults.set(numbers, forKey: Constants.UserDefaults.numberList)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numbers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = "\(numbers[indexPath.row])"
    return cell
  }
  
}

