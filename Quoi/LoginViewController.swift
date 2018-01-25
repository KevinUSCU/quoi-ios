//
//  LoginViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 1/18/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLoginField: UITextField!
    @IBOutlet weak var passwordLoginField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if let emailInput = emailLoginField.text, let passwordInput = passwordLoginField.text {
            print("\(emailInput) \(passwordInput)")
        }
    }
    
    // The next two functions allow a tap outside the keyboard area to dismiss the keyboard
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap))
        tapRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}
