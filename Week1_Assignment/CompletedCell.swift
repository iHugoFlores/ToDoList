//
//  CompletedCell.swift
//  Week1_Assignment
//
//  Created by Hugo Flores Perez on 3/21/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

class CompletedCell: UITableViewCell {
    
    let formatter = DateFormatter()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func setDueDate(dueDate: Date) {
        formatter.dateFormat = "yyyy-MM-dd"
        dueDateLabel.text = formatter.string(from: dueDate)
    }
}
