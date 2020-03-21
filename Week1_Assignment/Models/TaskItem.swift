//
//  TaskItem.swift
//  Week1_Assignment
//
//  Created by Hugo Flores Perez on 3/20/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

class TaskItem {
    var name: String
    var description: String
    var done: Bool
    var dueDate: Date
    var image: String
    
    init(name: String, description: String, dueDate: Date, image: String? = "") {
        self.name = name
        self.description = description
        self.done = false
        self.dueDate = dueDate
        self.image = image!
    }
    
    func setDone() {
        self.done = true
    }
    
    func update(name: String?, description: String?, dueDate: Date?, image: String? = "") {
        self.name = name!
        self.description = description!
        self.dueDate = dueDate!
        self.image = image!
    }
}

extension TaskItem {
    public class func getMockData() -> [TaskItem] {
        return [
            TaskItem(name: "Test 1", description: "Test Description", dueDate: Date(), image: "Test"),
            TaskItem(name: "Test 2", description: "Test Description", dueDate: Calendar.current.date(byAdding: .day, value: 1,to: Date())!),
            TaskItem(name: "Test 4", description: "Lain Description", dueDate: Date(), image: "Lain"),
            TaskItem(name: "Test 3", description: "Test Description", dueDate: Calendar.current.date(byAdding: .day, value: -1,to: Date())!)
        ]
    }
}
