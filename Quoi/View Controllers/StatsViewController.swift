//
//  StatsViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 2/1/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit
import Charts
import SwiftyJSON

class StatsViewController: UIViewController, StatsServiceDelegate {
    
    // MARK: Properties
    let statsService = StatsService()
    
    // MARK: View References
    @IBOutlet weak var dqCorrectTotal: UILabel!
    @IBOutlet weak var dqIncorrectTotal: UILabel!
    @IBOutlet weak var dqTotal: UILabel!
    @IBOutlet weak var dqSuccessPieChart: PieChartView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.statsService.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Request stats
        statsService.getDailyQuestionSuccessRate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Delegate Actions
    func dataReady(sender: StatsService) {
        // Fill in stat data
        let stats = QUOI_STATE.DAILY_QUESTION_SUCCESS_RATE!
        dqCorrectTotal.text = String(describing: stats["correct"])
        dqIncorrectTotal.text = String(describing: stats["incorrect"])
        dqTotal.text = String(describing: stats["total"])
        // Animate pie chart
        createDailyQuestionSuccessPieChart(seconds: 2)
    }
    
    // MARK: Define Pie Chart
    func createDailyQuestionSuccessPieChart(seconds: Int) { // This styles and "runs" the pie-chart timer graphic.
        if let stats = QUOI_STATE.DAILY_QUESTION_SUCCESS_RATE {
            let correctPercent = (stats["correct"].float! / stats["total"].float!) * 100
            let correctPercentString = correctPercent >= 0 ? String(format:"%.0f", correctPercent) + "%" : ""
            let correct = PieChartDataEntry(value: stats["correct"].double!, label: correctPercentString)
            let incorrect = PieChartDataEntry(value: stats["incorrect"].double!, label: nil)
            let dataSet = PieChartDataSet(values: [incorrect, correct], label: nil)
            let data = PieChartData(dataSet: dataSet)
            dqSuccessPieChart.data = data
            
            data.setDrawValues(false)
            dataSet.sliceSpace = 3
            dataSet.selectionShift = 5
            dataSet.colors = [ #colorLiteral(red: 0.8958201142, green: 0.1340064573, blue: 0.007739691861, alpha: 0.2487157534), #colorLiteral(red: 0.002184122516, green: 0.7691982728, blue: 0.003388864949, alpha: 1) ]
            dqSuccessPieChart.legend.enabled = false
            dqSuccessPieChart.chartDescription?.enabled = false
            dqSuccessPieChart.holeRadiusPercent = 0.0
            dqSuccessPieChart.holeColor = UIColor.clear
            dqSuccessPieChart.backgroundColor = UIColor.clear
            dqSuccessPieChart.transparentCircleColor = UIColor.clear
            dqSuccessPieChart.animate(yAxisDuration: Double(seconds), easingOption: ChartEasingOption.easeOutQuint)
        }
    }
    
    //MARK: Button Handlers
    @IBAction func menuButton(_ sender: UIButton) {
        REMOVE_USER_PREFS()
        let next = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(next!, animated: true, completion: nil)
    }
    
    
}

