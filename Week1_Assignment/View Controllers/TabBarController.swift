//
//  TabBarController.swift
//  Week1_Assignment
//
//  Created by Hugo Flores Perez on 3/21/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var taskItems = [TaskItem]()// TaskItem.getMockData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(UIApplicationDelegate.applicationDidEnterBackground(_:)),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil)
        
        do {
            // Try to load from persistence
            self.taskItems = try [TaskItem].readFromPersistence()
            print("Items read from storage: \(taskItems.count)")
        } catch let error as NSError {
            if error.domain == NSCocoaErrorDomain && error.code == NSFileReadNoSuchFileError {
                NSLog("No persistence file found, not necesserially an error...")
            } else {
                let alert = UIAlertController(
                    title: "Error",
                    message: "Could not load the to-do items!",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                NSLog("Error loading from persistence: \(error)")
            }
        }
    }
    
    @objc public func applicationDidEnterBackground(_ notification: NSNotification) {
        do {
            print("Wiriting items to storage")
            try taskItems.writeToPersistence()
        } catch let error {
            NSLog("Error writing to persistence: \(error)")
        }
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
