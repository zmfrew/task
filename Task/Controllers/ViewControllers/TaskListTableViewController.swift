//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Zachary Frew on 7/11/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Outlets
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else { return UITableViewCell() }
        let task = TaskController.shared.tasks[indexPath.row]
        cell.update(withTask: task)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.remove(task: task)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            guard let destinationVC = segue.destination as? TaskDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            let task = TaskController.shared.tasks[indexPath.row]
            destinationVC.task = task
            destinationVC.dueDateValue = task.due as? Date
        }
    }
    
}

// MARK: - Extension
extension TaskListTableViewController: ButtonTableViewCellDelegate {
    
    func buttonCellTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = TaskController.shared.tasks[indexPath.row]
        TaskController.shared.toggleIsCompleteFor(task: task)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
