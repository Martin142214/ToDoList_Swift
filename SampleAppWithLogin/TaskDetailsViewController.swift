//
//  TaskDetailsViewController.swift
//  SampleAppWithLogin
//
//  Created by Martin Kalonkin on 12/11/21.
//

import UIKit
import FirebaseFirestore


class TaskDetailsViewController: UIViewController {
    
    public var task: Task? = nil

    @IBOutlet weak var taskTitle: UILabel!
    
    @IBOutlet weak var taskDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskTitle.text = task?.Title
        taskDescription.text = task?.Description
        print("\(taskTitle.text), ... \(taskDescription.text)")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask(){
        
    }
}
