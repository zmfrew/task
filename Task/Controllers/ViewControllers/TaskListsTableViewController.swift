//
//  TaskListsTableViewController.swift
//  Task
//
//  Created by Zachary Frew on 7/12/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit
import CoreData

class TaskListsTableViewController: UITableViewController {
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.fetchedResultsController.delegate = self
    }
    
    // MARK: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskController.shared.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TaskController.shared.fetchedResultsController.sections?[section].name == "1" ? "Complete" : "Incomplete"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else { return UITableViewCell() }
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        cell.update(withTask: task)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            TaskController.shared.remove(task: task)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditDetail" {
            guard let destinationVC = segue.destination as? TaskDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            destinationVC.task = task
            destinationVC.dueDateValue = task.due as Date?
        }
    }
    
}


// MARK: - NSFetchedResultsController and ButtonTableViewCell Delegates Conformance
extension TaskListsTableViewController: NSFetchedResultsControllerDelegate, ButtonTableViewCellDelegate {
    
    // MARK: - NSFetchedResultsControllerDelegate Methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert:
            tableView.insertSections(indexSet, with: .automatic)
        case .delete:
            tableView.deleteSections(indexSet, with: .automatic)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    // MARK: - ButtonTableViewCellDelegate Method
    func buttonCellTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        TaskController.shared.toggleIsCompleteFor(task: task)
    }
    
}
