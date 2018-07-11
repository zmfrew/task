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
    var tasks: [Task] = []
    
//    var mockTasks: [Task] {
//        var mowLawn = Task(name: "Mow the lawn", notes: "opposite diagonal this time", due: Date())
//        var finishAssignment = Task(name: "Finish the assignment", notes: "implement core data")
//        var walkDog = Task(name: "Walk Finn", due: Date())
//        walkDog.isComplete = true
//        return [mowLawn, finishAssignment, walkDog]
//    }
    
    // MARK: - Initializers
    init() {
        self.tasks = fetchTasks()
    }
    
    // MARK: - Methods
    func add(taskWithName name: String, notes: String?, due: Date?) {
        _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func remove(task: Task) {
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    func fetchTasks() -> [Task] {
        var tasks = [Task]()
        let fetchRequest: NSFetchRequest = Task.fetchRequest()
        do {
            tasks = try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print("Error occured while fetching data: \(error.localizedDescription)")
        }
        
        return tasks
//        return mockTasks
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
