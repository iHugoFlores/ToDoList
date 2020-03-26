//
//  NewItemController.swift
//  Week1_Assignment
//
//  Created by Hugo Flores Perez on 3/22/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import UIKit

protocol NewItemControllerDelegate {
    func updateToDo(indexPath: IndexPath, newData: TaskItem)
    func createNewTodo(newItem: TaskItem)
}

class NewItemController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var titleStr: String?
    var item: TaskItem?
    var editItemIndex: IndexPath?
    
    var pickerData: [String] = ["None", "Lain"]

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var imgPicker: UIPickerView!
    
    var delegate: NewItemControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgPicker.delegate = self
        self.imgPicker.dataSource = self
        
        if let passedTitle = titleStr {
            self.title = passedTitle
        }
        
        if let toDoToEdit = item {
            titleField.text = toDoToEdit.name
            descriptionField.text = toDoToEdit.desc
            dueDatePicker.date = toDoToEdit.dueDate
            imgPicker.selectRow(getRowbyImageName(toDoToEdit.image), inComponent: 0, animated: true)
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func getRowbyImageName(_ imgName: String) -> Int {
        return pickerData.firstIndex(of: imgName) ?? 0
    }

    @IBAction func onDonePress(_ sender: Any) {
        let newTitle = titleField.text!
        let newDescription = descriptionField.text!
        let newDueDate = Calendar.current.startOfDay(for: dueDatePicker.date)
        let newImage = pickerData[imgPicker.selectedRow(inComponent: 0)]
        
        let newToDo = TaskItem(name: newTitle, description: newDescription, dueDate: newDueDate, image: newImage)
        
        self.navigationController?.popViewController(animated: true)
        
        if self.title == "New" {
            delegate?.createNewTodo(newItem: newToDo)
            return
        }
        
        if self.title == "Edit" {
            newToDo.done = item!.done
            delegate?.updateToDo(indexPath: editItemIndex!, newData: newToDo)
            return
        }
        
    }
}
