//
//  LoginViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 1/18/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginServiceDelegate {
    
    // MARK: Properties
    let loginService: LoginService = LoginService()
    @IBOutlet weak var emailLoginField: UITextField!
    @IBOutlet weak var passwordLoginField: UITextField!
    @IBOutlet weak var messageField: UILabel!
    @IBOutlet weak var loginButtonGraphic: UIButton!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loginService.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Animate appearance of input fields and login button
        emailLoginField.center.x -= view.bounds.width
        passwordLoginField.center.x -= view.bounds.width
        loginButtonGraphic.center.x -= view.bounds.width
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.emailLoginField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.05, options: [.curveEaseOut], animations: {
            self.passwordLoginField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.curveEaseOut], animations: {
            self.loginButtonGraphic.center.x += self.view.bounds.width
        }, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // This, along with handleSingleTap(), allow a tap outside the keyboard area to dismiss it
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap))
        tapRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // Login Button Handler
    @IBAction func loginButton(_ sender: UIButton) {
        if let emailInput = emailLoginField.text, let passwordInput = passwordLoginField.text {
            loginService.login(email: emailInput, password: passwordInput)
            self.view.endEditing(true) // This will hide the keyboard on submit
        }
    }
    
    // Called by LoginService delegate when a message is ready to display
    func dataReady(sender: LoginService) {
        // Change color of status message based on success or failure
        if QUOI_STATE.TOKEN == nil { messageField.textColor = UIColor.red }
        else { messageField.textColor = UIColor.blue }
        // Display message
        messageField.text = String(self.loginService.message!)
        self.messageField.reloadInputViews()
        // On success, wait 1 second, then advance to Loading Screen
        if QUOI_STATE.TOKEN != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                let next = self.storyboard?.instantiateViewController(withIdentifier: "QuoiLoader")
                self.present(next!, animated: false, completion: nil)
            }
        }
    }
    
}
