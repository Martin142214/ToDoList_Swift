//
//  RegisterViewController.swift
//  SampleAppWithLogin
//
//  Created by Martin Kalonkin on 12/6/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class RegisterViewController: UIViewController {

    
    @IBOutlet public weak var userNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        styleTheView()
    }
    
    func styleTheView(){
        //hide the error label if there are no errors
        errorLabel.alpha = 0;
        //applying the appropriate styling
        Utilities.styleTextField(userNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(registerButton)
        
    }

    func validateAllFields() -> String? {
        if userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Username field is empty"
        }
        else if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Email field is empty"
        }
        else if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Password field is empty"
        }
        
        if Utilities.isPasswordValid(passwordTextField.text!) == false {
            return "Password isn't at least 8 characters, doesn't contain a special character or a number!"
        }
        
        return nil
    }

    @IBAction func registerBtnTapped(_ sender: Any) {
        let errors = validateAllFields()
        
        if errors != nil {
            displayErrors(errors!)
        }
        else{
            let userName = userNameTextField.text!.trimmingCharacters(in: .whitespaces)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespaces)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespaces)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.displayErrors("There is an error while creating the user")
                }
                else{
                    let dbStorage = Firestore.firestore()
                    dbStorage.collection("users").addDocument(data: ["username":userName, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                            self.displayErrors("Error while saving the username")
                        }
                        else{
                            let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HVC") as? HomeTableViewController
                            
                            self.view.window?.rootViewController = homeViewController
                            self.view.window?.makeKeyAndVisible()
                        }
                    }
                }
            }
        }
    }
    
    func displayErrors(_ messageReturned:String){
        errorLabel.text! = messageReturned
        errorLabel.alpha = 1
    }
}

