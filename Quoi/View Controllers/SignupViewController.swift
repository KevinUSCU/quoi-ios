//
//  SignupViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 1/25/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, LoginServiceDelegate {
    
    // MARK: Properties
    let loginService: LoginService = LoginService()
    @IBOutlet weak var firstnameSignupField: UITextField!
    @IBOutlet weak var lastnameSignupField: UITextField!
    @IBOutlet weak var emailSignupField: UITextField!
    @IBOutlet weak var passwordSignupField: UITextField!
    @IBOutlet weak var signupMessageField: UILabel!
    @IBOutlet weak var signupButtonGraphic: UIButton!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loginService.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Animate appearance of input fields and login button
        firstnameSignupField.center.x  -= view.bounds.width
        lastnameSignupField.center.x  -= view.bounds.width
        emailSignupField.center.x  -= view.bounds.width
        passwordSignupField.center.x -= view.bounds.width
        signupButtonGraphic.center.x  -= view.bounds.width

        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.firstnameSignupField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.05, options: [.curveEaseOut], animations: {
            self.lastnameSignupField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.curveEaseOut], animations: {
            self.emailSignupField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.15, options: [.curveEaseOut], animations: {
            self.passwordSignupField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [.curveEaseOut], animations: {
            self.signupButtonGraphic.center.x += self.view.bounds.width
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
    
    // Signup button handler
    @IBAction func signupButton(_ sender: UIButton) {
        if let firstnameInput = firstnameSignupField.text, let lastnameInput = lastnameSignupField.text, let emailInput = emailSignupField.text, let passwordInput = passwordSignupField.text {
            loginService.signup(firstname: firstnameInput, lastname: lastnameInput, email: emailInput, password: passwordInput)
            self.view.endEditing(true) // This will hide the keyboard on submit
        }
    }
    
    // Called by LoginService delegate when a message is ready to display
    func dataReady(sender: LoginService) {
        // Change color of status message based on success or failure
        if QUOI_STATE.TOKEN == nil { signupMessageField.textColor = UIColor.red }
        else { signupMessageField.textColor = UIColor.blue }
        // Display message
        signupMessageField.text = String(self.loginService.message!)
        self.signupMessageField.reloadInputViews()
        // On success, wait 1.5 seconds, then advance to Loading Screen
        if QUOI_STATE.TOKEN != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                let next = self.storyboard?.instantiateViewController(withIdentifier: "QuoiLoader")
                self.present(next!, animated: false, completion: nil)
            }
        }
    }
    
    @objc func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

