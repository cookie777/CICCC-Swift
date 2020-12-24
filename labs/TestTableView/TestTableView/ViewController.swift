//
//  ViewController.swift
//  TestTableView
//
//  Created by Takayuki Yamaguchi on 2020-12-22.
//

import UIKit

var testData = Array(0...99).map{String($0)}

class ViewController: UIViewController {
    
    var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.cellLayoutMarginsFollowReadableWidth = true // width won't be too long!
        setupConstrains()
        
        
        tableView.dataSource = self
        tableView.delegate = self

        
        // register a UITableViewCell class that we want to have an instance of for each row.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "yanmer")
    }
    
    func setupConstrains(){
        tableView.matchParent()
    }

}


/*
 Delegate
 */


//https://martinlasek.medium.com/tutorial-adding-a-uitableview-programmatically-433cb17ae07d
// Delegating cell's task
extension ViewController: UITableViewDataSource{
    //Tell how many raws are there at each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.count
    }
    
    //Tell each cell, what to display
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // First we register what "UITableViewCell" to use, with its id.
        // After we register,it'll automatically create instance of cell
        // At this place, we look its each instance reference and modiefy it.
        let cell = tableView.dequeueReusableCell(withIdentifier: "yanmer", for: indexPath)
        cell.textLabel?.text = testData[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_: UITableView, didSelectRowAt: IndexPath){
        let cell = tableView.cellForRow(at: didSelectRowAt)!
//        let cell = tableView.dequeueReusableCell(withIdentifier: "yanmer", for: didSelectRowAt)
        cell.contentView.backgroundColor = .cyan
//        if cell.backgroundColor == .cyan{
//            cell.backgroundColor = .white
//        }else{
//            cell.backgroundColor = .cyan
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

}

