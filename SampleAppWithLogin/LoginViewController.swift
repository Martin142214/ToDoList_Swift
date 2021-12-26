//
//  LoginViewController.swift
//  SampleAppWithLogin
//
//  Created by Martin Kalonkin on 12/6/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        styleTheView()
    }
    
    func styleTheView(){
        errorLabel.alpha = 0;
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
    func validateAllFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Email field is empty"
        }
        else if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Password field is empty"
        }
        
        return nil
    }

    @IBAction func loginBtnTapped(_ sender: UIButton) {
        let error = validateAllFields()
        
        if error != nil {
            print("errors")
            displayErrors(error!)
        }
        else{
            let email = emailTextField.text!.trimmingCharacters(in: .whitespaces)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil{
                    print("enter")
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                }
                else{
                    print("LoginTapped")

                    let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HVC") as? HomeTableViewController
                    self.view.window?.rootViewController = homeViewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
    
    func displayErrors(_ messageReturned:String){
        errorLabel.text! = messageReturned
        errorLabel.alpha = 1
    }
}
