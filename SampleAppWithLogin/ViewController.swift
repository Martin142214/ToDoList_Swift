//
//  ViewController.swift
//  SampleAppWithLogin
//
//  Created by Martin Kalonkin on 12/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        styleTheView()
    }

    func styleTheView(){
        Utilities.styleFilledButton(registerButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    
}

