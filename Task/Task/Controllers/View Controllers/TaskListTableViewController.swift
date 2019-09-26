//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Josh Sparks on 9/25/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        TaskController.shared.toggleIsCompleteFor(task: task)
        sender.update(withTask: task)
    }
    
    
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.fetchedResultsController.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        TaskController.shared.fetchedResultsController.sectionIndexTitles[section] == "1" ? "Complete" : "Not Complete"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        TaskController.shared.fetchedResultsController.sections?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ButtonTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell
        if cell == nil { cell = ButtonTableViewCell()}
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        cell.update(withTask: task)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            TaskController.shared.remove(task: task)
        } else if editingStyle == .insert {
        }    
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let destinationVC = segue.destination as? TaskDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            destinationVC.task = task
        }
    }
}

extension TaskListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case.insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case.delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case.move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case.update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError()
        }
    }
    
    
}
