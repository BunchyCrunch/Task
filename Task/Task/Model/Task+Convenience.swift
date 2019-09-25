//
//  Task+Convenience.swift
//  Task
//
//  Created by Josh Sparks on 9/25/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    @discardableResult
    convenience init(name: String, notes: String? = nil, due: Date? = nil, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context:context)
        self.name = name
        self.notes = notes
        self.due = due
    }
}
