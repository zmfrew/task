//
//  Task+Convenience.swift
//  Task
//
//  Created by Zachary Frew on 7/11/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    // MARK: - Initializers
    convenience init(name: String, notes: String? = nil, due: Date? = nil, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.due = due
    }
    
}
