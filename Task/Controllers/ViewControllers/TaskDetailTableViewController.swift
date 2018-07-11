//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Zachary Frew on 7/11/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDueDateTF.inputView = dueDatePicker
        updateViews()
    }
    
    // MARK: - Outlets
    @IBOutlet weak var taskNameTF: UITextField!
    @IBOutlet weak var taskDueDateTF: UITextField!
    @IBOutlet weak var taskNotesTV: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let name = taskNameTF.text, !name.isEmpty, name != " " else { return }
        let notes = taskNotesTV.text
        
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: dueDateValue)
        } else {
            TaskController.shared.add(taskWithName: name, notes: notes, due: dueDateValue)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        taskDueDateTF.text = sender.date.stringValue()
        dueDateValue = dueDatePicker.date
    }
    
    @IBAction func userTappedView(_ sender: UITapGestureRecognizer) {
        taskNameTF.resignFirstResponder()
        taskDueDateTF.resignFirstResponder()
        taskNotesTV.resignFirstResponder()
    }
    
    
    // MARK: - Properties
    var task: Task?
    var dueDateValue: Date?
    
    // MARK: - Methods
    func updateViews() {
        guard let task = task, isViewLoaded else { return }
        title = task.name
        taskNameTF.text = task.name
        taskDueDateTF.text = (task.due as Date?)?.stringValue() 
            taskNotesTV.text = task.notes
    }
    
}
