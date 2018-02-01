//
//  DashboardViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 1/25/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit
import SwiftyJSON

class DashboardViewController: UIViewController, TipsServiceDelegate, StatsServiceDelegate {
    
    // MARK: Properties
    let tipsService = TipsService()
    let statsService = StatsService()
    
    // MARK: View References
    @IBOutlet weak var dailyTipDisplay: UILabel!
    
    @IBOutlet weak var sundaySlice: UIView!
    @IBOutlet weak var mondaySlice: UIView!
    @IBOutlet weak var tuesdaySlice: UIView!
    @IBOutlet weak var wednesdaySlice: UIView!
    @IBOutlet weak var thursdaySlice: UIView!
    @IBOutlet weak var fridaySlice: UIView!
    @IBOutlet weak var saturdaySlice: UIView!
    
    @IBOutlet weak var sundayDate: UILabel!
    @IBOutlet weak var mondayDate: UILabel!
    @IBOutlet weak var tuesdayDate: UILabel!
    @IBOutlet weak var wednesdayDate: UILabel!
    @IBOutlet weak var thursdayDate: UILabel!
    @IBOutlet weak var fridayDate: UILabel!
    @IBOutlet weak var saturdayDate: UILabel!
    
    @IBOutlet weak var sundayStatusIcon: UIImageView!
    @IBOutlet weak var mondayStatusIcon: UIImageView!
    @IBOutlet weak var tuesdayStatusIcon: UIImageView!
    @IBOutlet weak var wednesdayStatusIcon: UIImageView!
    @IBOutlet weak var thursdayStatusIcon: UIImageView!
    @IBOutlet weak var fridayStatusIcon: UIImageView!
    @IBOutlet weak var saturdayStatusIcon: UIImageView!
    
    @IBOutlet weak var todayQuestionButtonToggle: UIButton!
    
    // MARK: Button Handlers
    @IBAction func logoutButton(_ sender: UIButton) {
        REMOVE_USER_PREFS()
        let next = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(next!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reload tips and stats on return from another tab
        self.tipsService.delegate = self
        self.tipsService.getTipOfTheDay()
        self.statsService.delegate = self
        self.statsService.getDashboardStats()
        populateTip()
        populateDashboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Delegae Actions
    func dataReady(sender: TipsService) {
        populateTip()
    }
    
    func dataReady(sender: StatsService) {
        populateDashboard()
    }
    
    // MARK: Helper Functions
    func populateTip() {
        let tip = QUOI_STATE.TIP_OF_THE_DAY
        dailyTipDisplay.text = tip != nil ? tip : "(no tip is available)"
    }
    
    func getSliceColor(today: Bool) -> UIColor {
        if today { return #colorLiteral(red: 0.985263288, green: 0.8556560874, blue: 0.5286467671, alpha: 1) }
        else { return #colorLiteral(red: 0.9396105409, green: 0.9523811936, blue: 0.9523200393, alpha: 1) }
    }
    
    func getButtonImage(status: Bool?) -> UIImage {
        if status == nil {
            return #imageLiteral(resourceName: "status-circle")
        } else if status == true {
            return #imageLiteral(resourceName: "status-check")
        } else {
            return #imageLiteral(resourceName: "status-x")
        }
    }
    
    func populateDashboard() {
        let stats = QUOI_STATE.DASHBOARD_STATS!
        
        if stats != JSON.null {
            sundayDate.text = String(describing: stats["map"][0]["day"])
            mondayDate.text = String(describing: stats["map"][1]["day"])
            tuesdayDate.text = String(describing: stats["map"][2]["day"])
            wednesdayDate.text = String(describing: stats["map"][3]["day"])
            thursdayDate.text = String(describing: stats["map"][4]["day"])
            fridayDate.text = String(describing: stats["map"][5]["day"])
            saturdayDate.text = String(describing: stats["map"][6]["day"])
            
            sundaySlice.backgroundColor = getSliceColor(today: stats["map"][0]["today"].bool!)
            mondaySlice.backgroundColor = getSliceColor(today: stats["map"][1]["today"].bool!)
            tuesdaySlice.backgroundColor = getSliceColor(today: stats["map"][2]["today"].bool!)
            wednesdaySlice.backgroundColor = getSliceColor(today: stats["map"][3]["today"].bool!)
            thursdaySlice.backgroundColor = getSliceColor(today: stats["map"][4]["today"].bool!)
            fridaySlice.backgroundColor = getSliceColor(today: stats["map"][5]["today"].bool!)
            saturdaySlice.backgroundColor = getSliceColor(today: stats["map"][6]["today"].bool!)
            
            sundayStatusIcon.image = getButtonImage(status: stats["map"][0]["status"].bool)
            mondayStatusIcon.image = getButtonImage(status: stats["map"][1]["status"].bool)
            tuesdayStatusIcon.image = getButtonImage(status: stats["map"][2]["status"].bool)
            wednesdayStatusIcon.image = getButtonImage(status: stats["map"][3]["status"].bool)
            thursdayStatusIcon.image = getButtonImage(status: stats["map"][4]["status"].bool)
            fridayStatusIcon.image = getButtonImage(status: stats["map"][5]["status"].bool)
            saturdayStatusIcon.image = getButtonImage(status: stats["map"][6]["status"].bool)
            
            if stats["todayCompleted"].bool == true {
                todayQuestionButtonToggle.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                todayQuestionButtonToggle.setTitle("You have answered today's question", for: .disabled)
                todayQuestionButtonToggle.setTitleColor(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), for: .disabled)
                todayQuestionButtonToggle.isEnabled = false
            }
        }
    }
    
}
