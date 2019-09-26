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
    func add(taskWtihName name: String, notes: String?, due: Date?) {
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
        tasks = fetchTasks()
        
    }
    
    //Update
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due as Date?
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    //Remove
    func remove(task: Task) {
        task.managedObjectContext?.delete(task)
        saveToPersistentStore()
        tasks = fetchTasks()
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    private func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving")
        }
    }
    
    private func fetchTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
}
