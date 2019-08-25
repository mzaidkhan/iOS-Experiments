//
//  ToDoTableTableViewController.swift
//  ToDoList
//
//  Created by Mohammed Zaid Khan on 16.08.19.
//  Copyright © 2019 Mohammed Zaid Khan. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var toDoCDs:[ToDoCD] = []
    
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func getToDos(){
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let toDosFromCoreData = try? context.fetch(ToDoCD.fetchRequest()){
                if let toDos = toDosFromCoreData as? [ToDoCD]{
                    toDoCDs = toDos
                    tableView.reloadData()
                }
            }
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoCDs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let selectedToDo = toDoCDs[indexPath.row]
        if selectedToDo.priority == 1 {
            if let name = selectedToDo.name{
                cell.textLabel?.text = "❗️" + name
            }
        } else if selectedToDo.priority == 2 {
            if let name = selectedToDo.name {
                cell.textLabel?.text = "‼️" + name
            }
        } else {
            if let name = selectedToDo.name {
                cell.textLabel?.text = name
            }
        }
        if let data = selectedToDo.image {
            cell.imageView?.image = UIImage(data:data)            
        }
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedToDo = toDoCDs[indexPath.row]
        performSegue(withIdentifier: "moveToDetails", sender: selectedToDo)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let selectedToDo = toDoCDs[indexPath.row]
                context.delete(selectedToDo)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                getToDos()
            }
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addToDoViewController = segue.destination as? AddToDoViewController{
            addToDoViewController.toDoTableViewController = self            
        }
        
        if let detailsToDoViewController = segue.destination as? DetailsViewController{
            if let selectedToDo = sender as? ToDoCD{
                detailsToDoViewController.toDoCD = selectedToDo
            }
        }
    }
}
