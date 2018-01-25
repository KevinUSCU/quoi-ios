//
//  LoginViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 1/18/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginServiceDelegate {
    
    let loginService: LoginService = LoginService()
    @IBOutlet weak var emailLoginField: UITextField!
    @IBOutlet weak var passwordLoginField: UITextField!
    @IBOutlet weak var messageField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loginService.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if let emailInput = emailLoginField.text, let passwordInput = passwordLoginField.text {
            loginService.login(email: emailInput, password: passwordInput)
            self.view.endEditing(true) // this will hide the keyboard on submit
        }
    }
    
    func dataReady(sender: LoginService) {
        if self.loginService.token == nil { messageField.textColor = UIColor.red }
        else { messageField.textColor = UIColor.blue }
        messageField.text = String(self.loginService.message!)
        self.messageField.reloadInputViews()
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
