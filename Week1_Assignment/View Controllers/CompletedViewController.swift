//
//  CompletedViewController.swift
//  Week1_Assignment
//
//  Created by Hugo Flores Perez on 3/20/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//


import UIKit

class CompletedViewController: UITableViewController {
    
    var taskItems: [TaskItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.title = "Completed"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tabBar = tabBarController as! TabBarController
        taskItems = tabBar.taskItems.filter({(item: TaskItem) -> Bool in
            return item.done
        })
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "completed_todo_cell", for: indexPath) as! CompletedCell
        
        let item = taskItems[indexPath.row]
        
        cell.setTitle(title: item.name)
        cell.setDueDate(dueDate: item.dueDate)
        
        return cell
    }
}
