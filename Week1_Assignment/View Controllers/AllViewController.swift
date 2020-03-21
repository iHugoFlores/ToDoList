//
//  AllViewController.swift
//  Week1_Assignment
//
//  Created by Hugo Flores Perez on 3/20/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class AllViewController: UITableViewController, ToDoCellDelegate {
     var taskItems: [TaskItem] = []
     
     override func viewDidLoad() {
         super.viewDidLoad()
         let tabBar = tabBarController as! TabBarController
         taskItems = tabBar.taskItems
     }
     
     override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return taskItems.count
     }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "all_todo_cell", for: indexPath) as! ToDoCell
        let item = taskItems[indexPath.row]

        cell.setImage(image: item.image)
        cell.setTitle(title: item.name)
        cell.setDescription(description: item.description)
        cell.setDueDate(dueDate: item.dueDate)
        cell.setDone(done: item.done)
        cell.delegate = self

        return cell
     }
    
    func setTaskToDone(indexPath: IndexPath) {
        let tabBar = tabBarController as! TabBarController
        tabBar.setTaskToDone(id: indexPath)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let tabBar = tabBarController as! TabBarController
        tabBar.deleteToDo(at: indexPath)
        taskItems.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath)
    }
}
