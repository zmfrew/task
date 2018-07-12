//
//  TaskController.swift
//  Task
//
//  Created by Zachary Frew on 7/11/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    // MARK: - Singleton
    static var shared = TaskController()
    
    // MARK: - Properties
    let fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest: NSFetchRequest = Task.fetchRequest()
        let completeSort = NSSortDescriptor(key: "isComplete", ascending: false)
        let dueSort = NSSortDescriptor(key: "due", ascending: false)
        fetchRequest.sortDescriptors = [completeSort, dueSort]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error occurred while fetching: \(error.localizedDescription).")
        }
        
        return fetchedResultsController
    }()
    
    // MARK: - Methods
    func add(taskWithName name: String, notes: String?, due: Date?) {
        _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func remove(task: Task) {
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error occurred while saving: \(error.localizedDescription)")
        }
    }
    
}
