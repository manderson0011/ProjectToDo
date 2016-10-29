//
//  ToDosTableViewController.swift
//  ToDoTakingAppAnderson
//
//  Created by Melissa Anderson on 10/18/16.
//  Copyright © 2016 Melissa Anderson. All rights reserved.
//

import UIKit
import UserNotifications

class ToDosTableViewController: UITableViewController {
    
    var onlyIfComplete = false
    var searchDisplayController: UISearchController
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    @IBAction func showOnlyComplete(_ sender: AnyObject) {
        onlyIfComplete = !onlyIfComplete
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //      navigationItem.Toolbar = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        //       navigationItem.Toolbar = UIBarButtonI tem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
        
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    // example contacts each section.. a, b, c.. the person name is a row.   we want a row for each toDo
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoStore.shared.getCount(category: section)
    }
    
    // Mark: - switch for the section on the table view.
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Home To Do List"
        case 1:
            return "Work To Do List"
        case 2:
            return "Misc To Do List"
        case 3:
            return ""
        default:
            return "Section does not exist"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ToDoTableViewCell.self)) as! ToDoTableViewCell
        
        cell.setupCell(ToDoStore.shared.getToDo(indexPath.row, category: indexPath.section))
        cell.setupCell(ToDoStore.shared.getToDo(indexPath.row, category: indexPath.section))
        
        
        //MARK:  switch for complete:
        
        if onlyIfComplete == false {
            
            if cell.toDo.completion == true {
                cell.isHidden = true
            }
            
        }
        return cell
    }
    // takes empty space away when row is hidden
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ToDoStore.shared.getToDo(indexPath.row, category: indexPath.section).completion == true && onlyIfComplete == false {
            return 0
        } else {
            return 138
        }
    }
    
    
    
    //MARK - SEARCH CONTROLLER SEARCH BAR
    
    //    let category: Category
    //    if searchController.isActive && searchController.searchBar.text != "" {
    //    category = filteredCategory[indexPath.row]
    //    } else {
    //    Category = category[indexPath.row]
    //    }
    //    cell.textLabel?.category: indexPath.section = indexPath.section
    //    cell.detailTextLabel?.text = indexPath.section
    
    // Configure the cell...
    
    
    //MARK: - ADDING THE ABILITY TO MAKE CELLS REORDERABLE
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ToDoStore.shared.deleteToDo(indexPath.row, category: indexPath.section)  //  deletes rows in toDos as needed !!! AWESOME
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Rearrange the table view.  use first.
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section != proposedDestinationIndexPath.section {
            return sourceIndexPath
        } else {
            return proposedDestinationIndexPath
        }
    }
    
    //  Override to support rearranging the table view via priority.  use next
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    //MARK: - LOCAL NOTIFICATION FUNCTION
    func scheduleLocal() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Wake UP"
        content.body = "Seize The Day."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default()
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    /// this lets us connect the seque so that we can edit
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditToDoSegue" {
            let toDoDetailVC = segue.destination as! ToDoDetailViewController
            let tableCell = sender as! ToDoTableViewCell
            toDoDetailVC.toDo = tableCell.toDo
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //MARK: EDIT BAR BUTTON
    @IBAction func showEditing(sender: UIBarButtonItem)
    {
        if(self.tableView.isEditing == true)
        {
            self.tableView.isEditing = false
            self.navigationItem.rightBarButtonItem?.title = "Done"
        }
        else
        {
            self.tableView.isEditing = true
            self.navigationItem.rightBarButtonItem?.title = "Edit"
        }
    }
    
    //MARK: unwind Segue   ---  this lets us edit the toDos// else adds another toDo so user can add as many toDos  as possible
    
    @IBAction func saveToDoDetail(_ segue: UIStoryboardSegue){
        let toDoDetailVC = segue.source as! ToDoDetailViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            ToDoStore.shared.sort()
            
            var indexPaths: [IndexPath] = []
            for index in 0...indexPath.row {
                indexPaths.append(IndexPath(row: index, section: 0))
                
            }
            
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }else{
            toDoDetailVC.toDo.priority = ToDoStore.shared.getPriority(category: toDoDetailVC.toDo.category)
            ToDoStore.shared.addToDo(toDoDetailVC.toDo, category: toDoDetailVC.toDo.category)
            let indexPath = IndexPath(row: 0, section: toDoDetailVC.toDo.category)
            tableView.insertRows(at: [indexPath], with: .automatic)// several options available automatic - when upgrades are made the style will be changed to defaults to other systems.
        }
        
    }
    
}

