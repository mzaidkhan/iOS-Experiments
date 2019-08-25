//
//  DetailsViewController.swift
//  ToDoList
//
//  Created by Mohammed Zaid Khan on 16.08.19.
//  Copyright © 2019 Mohammed Zaid Khan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var toDoCD: ToDoCD? = nil
    
    @IBOutlet weak var ToDoLabel: UILabel!
    
    @IBAction func doneTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let toDo = toDoCD {
                context.delete(toDo)            
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let toDo = toDoCD {
            if toDo.priority == 1 {
                if let name = toDo.name {
                    ToDoLabel.text = "❗️" + name
                }
            } else if toDo.priority == 2 {
                if let name = toDo.name {
                    ToDoLabel.text = "‼️" + name
                }
            }
            else {
                if let name = toDo.name {
                    ToDoLabel.text = name
                }
            }
        }
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
