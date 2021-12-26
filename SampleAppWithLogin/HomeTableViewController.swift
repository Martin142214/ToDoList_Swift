//
//  HomeTableViewController.swift
//  SampleAppWithLogin
//
//  Created by Martin Kalonkin on 12/23/21.
//

import UIKit
import Firebase
import FirebaseFirestore

struct Task : Decodable {
    var Title: String?
    var Description: String?
}

class HomeTableViewController: UITableViewController {
        
        public var tasks: [Task] = []
        
        var taskTitle: String?
        var taskDescription:String?

        
        func ViewDidLoad() {
            super.viewDidLoad()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            
            tableView.accessibilityIdentifier = "cell"
            
            self.title = "tasks"
            
            tableView.dataSource = self
            tableView.delegate = self
            
            self.renderTasks()
        }
            
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tasks.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            let selectedToDo = tasks[indexPath.row]
            cell.textLabel?.text = selectedToDo.Title
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            tableView.deselectRow(at: indexPath, animated: true)
            
            let taskDetailsVC = storyboard?.instantiateViewController(withIdentifier: "DetailsVC")
                as? TaskDetailsViewController
            taskDetailsVC?.title = "Task details"
            let selectedToDo = tasks[indexPath.row]
            taskTitle = selectedToDo.Title
            taskDescription = selectedToDo.Description
            print("DidSelectrow happened")
            //navigationController?.pushViewController(taskDetailsVC!, animated: true)
            performSegue(withIdentifier: "taskDetails", sender: selectedToDo)
        }
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if let detailsController = segue.destination as? TaskDetailsViewController {
                    if let selectedToDo = sender as? Task {
                        detailsController.task = selectedToDo
                        print("Selectedtodo")
                        print(selectedToDo)
                    }
                }
            }

        
        func getCountOfDocs() -> Int {
            let db = Firestore.firestore()
            var count: Int? = 0
            db.collection("tasks").getDocuments()
            {
                (querySnapshot, err) in

                if let err = err
                {
                    print("Error getting documents: \(err)");
                }
                else
                {
                    count = querySnapshot?.documents.count
                }
            }
            return count!
        }
        
    
        func renderTasks(){
            //tasks.removeAll()
            print("in rendertasks method")
            
            let db = Firestore.firestore()
            do{
                db.collection("tasks").getDocuments()
                {
                    (querySnapshot, err) in
                    if let err = err
                    {
                        print("Error getting documents: \(err)");
                    }
                    else
                    {
                        do{
                            self.tasks = try querySnapshot!.decoded()
                            print("All tasks as objects:")
                            self.tasks.forEach({x in
                                print(x)
                            })
                        }
                        catch let error as NSError{
                            print(error)
                        }
                        
                    }
                    self.tableView.reloadData()
                }
            }
            catch let error as NSError{
                print("fail, \(error)")
            }
        }
        
        @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
            let transitViewContr = storyboard?.instantiateViewController(withIdentifier: "TransitVC") as! TransitViewController
            print("in addbtn func")
            transitViewContr.title = "New task"
            DispatchQueue.main.async {
                self.renderTasks()
            }
            navigationController?.pushViewController(transitViewContr, animated: true)
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
