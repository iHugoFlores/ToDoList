//
//  AllViewController.swift
//  Week1_Assignment
//
//  Created by Hugo Flores Perez on 3/20/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class AllViewController: UITableViewController, ToDoCellDelegate, NewItemControllerDelegate {
     var taskItems: [TaskItem] = []
     
    // Initialize items on screen load
     override func viewDidLoad() {
         super.viewDidLoad()
         let tabBar = tabBarController as! TabBarController
         taskItems = tabBar.taskItems
     }
    
     // Just 1 section
     override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }

    // Number of rows of the list
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return taskItems.count
     }

    // Render each cell at a particular indexPath
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "all_todo_cell", for: indexPath) as! ToDoCell
        let item = taskItems[indexPath.row]

        cell.setImage(image: item.image)
        cell.setTitle(title: item.name)
        cell.setDescription(description: item.desc)
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
    
    // Handle swipe-to-delete action
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let tabBar = tabBarController as! TabBarController
        tabBar.deleteToDo(at: indexPath)
        taskItems.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    // Row press action
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "AddItemSegue",
            let editScreen = segue.destination as? NewItemController {
            editScreen.delegate = self;
            editScreen.titleStr = "New";
            return
        }
        if  let editScreen = segue.destination as? NewItemController,
            let cell = sender as? ToDoCell,
            let indexPath = tableView.indexPath(for: cell) {
            editScreen.delegate = self;
            editScreen.titleStr = "Edit";
            editScreen.item = taskItems[indexPath.row];
            editScreen.editItemIndex = indexPath
        }
    }
    
    func updateToDo(indexPath: IndexPath, newData: TaskItem) {
        let tabBar = tabBarController as! TabBarController
        tabBar.updateToDo(newData, indexPath)
        taskItems[indexPath.row] = newData
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func createNewTodo(newItem: TaskItem) {
        let tabBar = tabBarController as! TabBarController
        tabBar.addToDo(newItem)
        taskItems[0..<0] = [newItem]
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
}
