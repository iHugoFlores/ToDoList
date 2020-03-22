//
//  TaskItem.swift
//  Week1_Assignment
//
//  Created by Hugo Flores Perez on 3/20/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

class TaskItem: NSCoder, NSCoding {
    var name: String
    var desc: String
    var done: Bool
    var dueDate: Date
    var image: String
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(desc, forKey: "desc")
        coder.encode(done, forKey: "done")
        coder.encode(dueDate, forKey: "dueDate")
        coder.encode(image, forKey: "image")
    }
    
    required init?(coder aDecoder: NSCoder) {
        if  let name = aDecoder.decodeObject(forKey: "name") as? String,
            let desc = aDecoder.decodeObject(forKey: "desc") as? String,
            let image = aDecoder.decodeObject(forKey: "image") as? String,
            let dueDate = aDecoder.decodeObject(forKey: "dueDate") as? Date {
            self.name = name
            self.desc = desc
            self.done = aDecoder.decodeBool(forKey: "done")
            self.dueDate = dueDate
            self.image = image
        } else { return nil }
    }
    
    init(name: String, description: String, dueDate: Date, image: String? = "") {
        self.name = name
        self.desc = description
        self.done = false
        self.dueDate = dueDate
        self.image = image!
    }
    
    func setDone() {
        self.done = true
    }
    
    func update(name: String?, description: String?, dueDate: Date?, image: String? = "") {
        self.name = name!
        self.desc = description!
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

extension Collection where Iterator.Element == TaskItem {
    private static func persistencePath() -> URL? {
        let url = try? FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true)

        return url?.appendingPathComponent("todoitems.bin")
    }
    
    // Write the array to persistence
    func writeToPersistence() throws
    {
        if let url = Self.persistencePath(), let array = self as? NSArray
        {
            let data = NSKeyedArchiver.archivedData(withRootObject: array)
            try data.write(to: url)
        }
        else
        {
            throw NSError(domain: "com.example.MyToDo", code: 10, userInfo: nil)
        }
    }
    
    // Read the array from persistence
    static func readFromPersistence() throws -> [TaskItem]
    {
        if let url = persistencePath(), let data = (try Data(contentsOf: url) as Data?)
        {
            if let array = NSKeyedUnarchiver.unarchiveObject(with: data) as? [TaskItem]
            {
                return array
            }
            else
            {
                throw NSError(domain: "com.example.MyToDo", code: 11, userInfo: nil)
            }
        }
        else
        {
            throw NSError(domain: "com.example.MyToDo", code: 12, userInfo: nil)
        }
    }
}
