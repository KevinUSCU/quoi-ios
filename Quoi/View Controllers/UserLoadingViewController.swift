//
//  UserLoadingViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 1/31/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit

class UserLoadingViewController: UIViewController, LoginServiceDelegate, TipsServiceDelegate, StatsServiceDelegate {
    
    // MARK: Properties
    let loginService: LoginService = LoginService()
    let tipsService: TipsService = TipsService()
    let statsService: StatsService = StatsService()
    
    // MARK: Delegate Actions
    func dataReady(sender: LoginService) {
        // Verify we got user data by checking for continued existence of token (it gets deleted if determined to be invalid)
        if QUOI_STATE.TOKEN == nil { // Redirect back to login page
            let next = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(next!, animated: false, completion: nil)
        } else {
            // Now that we have user data, load tip of the day
            tipsService.getTipOfTheDay()
        }
    }
    
    func dataReady(sender: TipsService) {
        // Now that we have the tip of the day, load dashboard stats for user
        statsService.getDashboardStats()
    }
    
    func dataReady(sender: StatsService) {
        // Now that we have all data, advance to dashboard view (via MainNav)
        let next = self.storyboard?.instantiateViewController(withIdentifier: "MainNav")
        self.present(next!, animated: false, completion: nil)
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.loginService.delegate = self
        self.tipsService.delegate = self
        self.statsService.delegate = self
        
        // Load data stored on disk
        LOAD_USER_PREFS()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check for existing user token
        if QUOI_STATE.TOKEN == nil { // If none, send to login/signup
            let next = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(next!, animated: false, completion: nil)
        } else { // If present, begin signin sequence
            loginService.setStateWithUserDataFromToken(token: QUOI_STATE.TOKEN!, firstVisit: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
