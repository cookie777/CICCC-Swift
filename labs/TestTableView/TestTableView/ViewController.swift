//
//  ViewController.swift
//  TestTableView
//
//  Created by Takayuki Yamaguchi on 2020-12-22.
//

import UIKit

var testData = Array(0...99).map{String($0)}
var isTappedSet: Set<Int> = []

class ViewController: UIViewController {
    
    // First of all we need to creat a table view
    var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //same as other view, add to super view and set constrains
        view.addSubview(tableView)
        setupConstrains()
        
        //Widh this, the width will not be very long in iPad or large screen == readalbe!
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        //Send to two delegate in table View
        tableView.dataSource = self
        tableView.delegate = self

        
        // Regisering <UITableViewCell> as cell of tableview
        // "Regiser" means "Hey table view! I wanna use this class instance as a cell"
        // Besides, we name this registeration to make it unique == identifier
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "yanmer")
    }
    
    func setupConstrains(){
        // This is just setting constrain(to be same as parent view) by using extension
        tableView.matchParent()
    }

}


/*
 Here are the method overriding for delegate used in table views
 Threre are two delegate "DataSource" and "Delegate"
 "DataSource" is must, we need it.
    - We set the number of cell we want to show in total.
    - We set what kind of cell do we display
 "Delegate" is optional, don't always need.
    - We can set cell's height or action we the cell is selected.
 // https://martinlasek.medium.com/tutorial-adding-a-uitableview-programmatically-433cb17ae07d
 */


extension ViewController: UITableViewDataSource{
    //*Must: Tell how many raws we want to display in total at each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Mostly we want to show larger than the number of data, otherwise we can't show all of them!
        return testData.count
    }
    
    //*Must: Tell each cell, what to display
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // First of all we need to get cell where going to use.
        // We're not gonna create from a new instance.
        // There is a queue that stores reusable cell.
        // We dequeue it and use it.
        // When we dequeue, we need to tell "what to use" and "where to use".
        // "what to use" == `withIdentifier` == "Oh, I wanna use a cell which type is the one I regisered!"
        // "where to use " == "Oh, I wanna use this cell at this place". Mostly it's indexPath(the current place we are configuring)
        let cell = tableView.dequeueReusableCell(withIdentifier: "yanmer", for: indexPath)
    
        
        // Now we got the reusable cell so let's modify!
        // But before that, we have to reset all the setting of cell,
        // because there still pocesses the previous setting!
        cell.contentView.backgroundColor = .white
        
        // Now the cell is new! Let's modify as we want.
        cell.textLabel?.text = testData[indexPath.row]
        
        

        // We reset the cell, but if we go back to the same position,
        // we have to recall(restore) the setting.
        // So we record each cell's setting in some places (eg, in other variables),
        // Then, by looking that varibales, we know "when to" and "how to restore".
        // This is the setting for on/off description
        if isTappedSet.contains(indexPath.row){
            cell.contentView.backgroundColor = .cyan
        }
        

        return cell
    }
}







extension ViewController: UITableViewDelegate{
    
    // Don't need
    // Set an action(behavior) when the cell is celected
    func tableView(_: UITableView, didSelectRowAt: IndexPath){
        
        // Caution! : We are not dequeue resuable cell.
        // When seleced == the reusable cell is already exit!
        // All we do is just get the cell that is celected by using specifying the current index
        guard let cell = tableView.cellForRow(at: didSelectRowAt) else {return}
        
        let curIndex = didSelectRowAt.row

        // By looking record, we decide what to do.
        // If it's already tappded -> return to default and erase from the record
        // not tapped -> chage the color of background and record its index.
        if isTappedSet.contains(curIndex) {
            isTappedSet.remove(curIndex)
            cell.contentView.backgroundColor = .white
        }else{
            isTappedSet.insert(curIndex)
            cell.contentView.backgroundColor = .cyan
        }
    }
    
    
    // Don't need. But you can modify cell's hight.
    // There are some other func you can override and modify talbe view!
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

}

