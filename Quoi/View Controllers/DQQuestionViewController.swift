//
//  DQQuestionViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 1/27/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit
import Charts

class DQQuestionViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var timerCountdown: UILabel!
    
    weak var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        startTimer()
        setTimerPieChart(seconds: 60)
        
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
    
    func startTimer() {
        var countdown = 60
        timerCountdown.text = ":\(String(describing: countdown))"
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            countdown -= 1
            if countdown > 9 {
                self?.timerCountdown.text = ":\(String(describing: countdown))"
            } else if countdown > 0 {
                self?.timerCountdown.text = ":0\(String(describing: countdown))"
            } else {
                self?.timerCountdown.text = ":00"
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    // if appropriate, make sure to stop your timer in `deinit`
    
    deinit {
        stopTimer()
    }
    
    func setTimerPieChart(seconds: Int) {
        var dataEntries: [ChartDataEntry] = []
        let dataEntry = ChartDataEntry(x: Double(seconds), y: 1)
        dataEntries.append(dataEntry)
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        pieChartDataSet.colors = [UIColor.white]
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartView.drawHoleEnabled = false
        pieChartView.legend.enabled = false
        pieChartView.chartDescription?.enabled = false
        pieChartView.isUserInteractionEnabled = false
        pieChartView.transparentCircleColor = UIColor.clear
        pieChartView.data?.setDrawValues(false)
        pieChartView.animate(yAxisDuration: Double(seconds), easingOption: ChartEasingOption.linear)
    }
}
