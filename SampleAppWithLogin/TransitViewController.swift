//
//  TransitViewController.swift
//  SampleAppWithLogin
//
//  Created by Martin Kalonkin on 12/9/21.
//

import UIKit
import FirebaseFirestore
import SwiftUI

class TransitViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var taskTitle: UITextField!
    
    @IBOutlet weak var taskDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        taskDescription.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(addAndSaveTask))
        // Do any additional setup after loading the view.
    }
    
    /*
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        addAndSaveTask()
        
        return true
    }
    */
    
    func setDate() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timestamp = format.string(from: date)
        return timestamp
    }

    @objc func addAndSaveTask() {
        if taskTitle.text?.trimmingCharacters(in: .whitespaces) == "" {
            return
        }
        else if taskDescription.text?.trimmingCharacters(in: .whitespaces) == "" {
            return
        }
        else{
            let db = Firestore.firestore()
            //let documentId = "AbFqhxRkQQaaPE9iLzno"
            
            db.collection("tasks").addDocument(data: [
                "Title": taskTitle.text!,
                "Date": self.setDate(),
                "Description": taskDescription.text!
            ]) { err in
                if let err = err {
                    print("Error writing task: \(err)")
                } else {
                    print("Task successfully written!")
                }
            }
            navigationController?.popViewController(animated: true)
        }
        
    }
}
