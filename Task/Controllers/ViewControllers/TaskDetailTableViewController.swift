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
        updateViews()
    }
    
    // MARK: - Outlets
    @IBOutlet weak var taskNameTF: UITextField!
    @IBOutlet weak var taskDueDateTF: UITextField!
    @IBOutlet weak var taskNotesTV: UITextView!
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let name = taskNameTF.text, !name.isEmpty, name != " ", let notes = taskNotesTV.text, !notes.isEmpty, notes != " " else { return }
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: dueDateValue)
        }
        TaskController.shared.add(taskWithName: name, notes: notes, due: dueDateValue)
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Properties
    var task: Task?
    var dueDateValue: Date?
    
    // MARK: - Methods
    func updateViews() {
        guard let task = task, isViewLoaded else { return }
        title = task.name
        taskNameTF.text = task.name
            taskDueDateTF.text = task.due?.description // FIXME: maybe change this to 'dueDateValue'
            taskNotesTV.text = task.notes
    }
    
}
