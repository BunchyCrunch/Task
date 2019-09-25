//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Josh Sparks on 9/25/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    var task: Task?{
        didSet {
            updateViews()
        }
    }
    var dueDateValue: Date?
    
    //MARK: -Outlets
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var dueDateTextField: UITextField!
    
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateTextField.inputView = dueDatePicker
        updateViews()
    }
//MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        updateTask()
        let _ = navigationController?.popViewController(animated: true)
        }
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        self.dueDateTextField.text = sender.date.stringValue()
        self.dueDateValue = sender.date
    }
    @IBAction func userTappedView(_ sender: Any) {
        self.nameTextField.resignFirstResponder()
        self.dueDateTextField.resignFirstResponder()
        self.notesTextView.resignFirstResponder()
    }
    
    //MARK: - Private
    private func updateTask() {
        guard let name = nameTextField.text else { return }
        let dueDate = dueDateValue
        let notes = notesTextView.text
        if let task = self.task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: dueDate)
        } else {
            TaskController.shared.add(taskWtihName: name, notes: notes, due: dueDate)
        }
    }
    
    private func updateViews() {
        guard let task = task, isViewLoaded else { return }
        let title = task.name
        nameTextField.text = task.name
        dueDateTextField.text = task.due?.stringValue()
        notesTextView.text = task.notes
    }
}
