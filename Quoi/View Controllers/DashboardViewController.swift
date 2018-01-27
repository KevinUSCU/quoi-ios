//
//  DashboardViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 1/25/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, TipsServiceDelegate {
    
    let tipsService = TipsService()
    @IBOutlet weak var dailyTipDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tipsService.delegate = self
        self.tipsService.getTipOfTheDay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataReady(sender: TipsService) {
        dailyTipDisplay.text = String(self.tipsService.tipOfTheDay!)
        self.dailyTipDisplay.reloadInputViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tipsService.delegate = self
        self.tipsService.getTipOfTheDay()
    }
}
