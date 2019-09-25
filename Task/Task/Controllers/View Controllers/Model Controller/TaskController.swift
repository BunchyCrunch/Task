//
//  TaskController.swift
//  Task
//
//  Created by Josh Sparks on 9/25/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static var shared = TaskController()
    var tasks: [Task] = []
    
    
    //Create
    func add(taskWtihName: String, notes: String?, due: Date?) {
        
    }
    
    //Update
    func update(task: Task, name: String, notes: String?, due: Date?) {
        
    }
    
    //Remove
    func remove(task: Task) {
        
    }
    
    
    func saveToPersistenStore() {
        
    }
    
    func fetchTasks() -> [Task] {
        return tasks
    }
    
}
