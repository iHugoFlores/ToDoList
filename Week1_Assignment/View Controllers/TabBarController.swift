//
//  TabBarController.swift
//  Week1_Assignment
//
//  Created by Hugo Flores Perez on 3/21/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var taskItems = TaskItem.getMockData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskItems[0].setDone()
    }
    
    func setTaskToDone(id row: IndexPath) {
        let item = taskItems[row.row]
        item.setDone()
    }
    
    func deleteToDo(at indexPath: IndexPath) {
        taskItems.remove(at: indexPath.row)
    }

    func addToDo(_ newItem: TaskItem) {
        taskItems[0..<0] = [newItem]
    }
    
    func updateToDo(_ newItem: TaskItem, _ indexPath: IndexPath) {
        taskItems[indexPath.row] = newItem
    }
}
