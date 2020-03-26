//
//  ToDoCell.swift
//  Week1_Assignment
//
//  Created by Hugo Flores Perez on 3/21/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

protocol ToDoCellDelegate {
    func setTaskToDone(indexPath: IndexPath)
}

class ToDoCell: UITableViewCell {
    
    let formatter = DateFormatter()

    @IBOutlet weak var todoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var setDoneButton: UIButton!
    
    var tableView:UITableView?{
        return superview as? UITableView
    }

    var delegate: ToDoCellDelegate?
    
    func setImage(image: String) {
        switch image {
            case "Lain":
                todoImageView.image = #imageLiteral(resourceName: "Lain")
            default:
                todoImageView.image = #imageLiteral(resourceName: "empty")
        }
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func setDescription(description: String) {
        descriptionLabel.text = description
    }
    
    func setDueDate(dueDate: Date) {
        formatter.dateFormat = "yyyy-MM-dd"
        dueDateLabel.text = formatter.string(from: dueDate)
        if dueDate < Calendar.current.startOfDay(for: Date()) {
            self.backgroundColor = UIColor(red: 1, green: 0.498, blue: 0.498, alpha: 1.0)
        }
    }
    
    func setDone(done: Bool) {
        setDoneButton.isHidden = done
        self.accessoryType = done ? .checkmark : .none
        self.accessoryView?.backgroundColor = .red
    }

    @IBAction func onComplete(_ sender: Any) {
        let selfIndexPath = (tableView?.indexPath(for: self))!
        delegate?.setTaskToDone(indexPath: selfIndexPath)
    }
    
}
