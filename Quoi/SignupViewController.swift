//
//  SignupViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 1/25/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, LoginServiceDelegate {
    
    let loginService: LoginService = LoginService()
    @IBOutlet weak var firstnameSignupField: UITextField!
    @IBOutlet weak var lastnameSignupField: UITextField!
    @IBOutlet weak var emailSignupField: UITextField!
    @IBOutlet weak var passwordSignupField: UITextField!
    @IBOutlet weak var signupMessageField: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        emailSignupField.center.x  -= view.bounds.height
        passwordSignupField.center.x -= view.bounds.width

        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut],
            animations: {
                self.emailSignupField.center.x += self.view.bounds.height
            },
            completion: nil
        )
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveEaseOut],
            animations: {
                self.passwordSignupField.center.x += self.view.bounds.width
            },
            completion: nil
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loginService.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupButton(_ sender: UIButton) {
        if let firstnameInput = firstnameSignupField.text, let lastnameInput = lastnameSignupField.text, let emailInput = emailSignupField.text, let passwordInput = passwordSignupField.text {
            loginService.signup(firstname: firstnameInput, lastname: lastnameInput, email: emailInput, password: passwordInput)
            self.view.endEditing(true) // this will hide the keyboard on submit
        }
    }
    
    func dataReady(sender: LoginService) {
        if self.loginService.token == nil { signupMessageField.textColor = UIColor.red }
        else { signupMessageField.textColor = UIColor.blue }
        signupMessageField.text = String(self.loginService.message!)
        self.signupMessageField.reloadInputViews()
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

