//
//  DQQuestionViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 1/27/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit
import Charts
import SwiftyJSON

class DQQuestionViewController: UIViewController {

    // MARK: Properties
    weak var timer: Timer?
    
    // MARK: View References
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var timerCountdown: UILabel!
    @IBOutlet weak var answerAText: UIButton!
    @IBOutlet weak var answerBText: UIButton!
    @IBOutlet weak var answerCText: UIButton!
    @IBOutlet weak var answerDText: UIButton!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Display question on page
        questionField.text = QUOI_STATE.QUESTION_OF_THE_DAY?["question"].string
        answerAText.setTitle(QUOI_STATE.QUESTION_OF_THE_DAY?["choices"][0].string, for: .normal)
        answerBText.setTitle(QUOI_STATE.QUESTION_OF_THE_DAY?["choices"][1].string, for: .normal)
        answerCText.setTitle(QUOI_STATE.QUESTION_OF_THE_DAY?["choices"][2].string, for: .normal)
        answerDText.setTitle(QUOI_STATE.QUESTION_OF_THE_DAY?["choices"][3].string, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Start 60 second timer
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
    
    // MARK: Countdown Timer
    
    func startTimer() { // This is for the numerical clock and knowing when we've run out of time
        var countdown = 60
        timerCountdown.text = ":\(String(describing: countdown))"
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            countdown -= 1
            if countdown > 9 {
                self?.timerCountdown.text = ":\(String(describing: countdown))"
            } else if countdown > 0 {
                self?.timerCountdown.text = ":0\(String(describing: countdown))"
            } else if countdown == 0 {
                self?.timerCountdown.text = ":00"
            } else {
                // Time is up, advance to next screen
                QUOI_STATE.QUESTION_ANSWER = -1
                self?.stopTimer()
                let next = self?.storyboard?.instantiateViewController(withIdentifier: "Relevant")
                self?.present(next!, animated: true, completion: nil)
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    func setTimerPieChart(seconds: Int) { // This styles and "runs" the pie-chart timer graphic.
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
    
    //MARK: Button Handlers
    
    @IBAction func answerAButton(_ sender: UIButton) {
        QUOI_STATE.QUESTION_ANSWER = 0
        stopTimer()
        let next = self.storyboard?.instantiateViewController(withIdentifier: "Relevant")
        self.present(next!, animated: true, completion: nil)
    }
    
    @IBAction func answerBButton(_ sender: UIButton) {
        QUOI_STATE.QUESTION_ANSWER = 1
        stopTimer()
        let next = self.storyboard?.instantiateViewController(withIdentifier: "Relevant")
        self.present(next!, animated: true, completion: nil)
    }
    
    @IBAction func answerCButton(_ sender: UIButton) {
        QUOI_STATE.QUESTION_ANSWER = 2
        stopTimer()
        let next = self.storyboard?.instantiateViewController(withIdentifier: "Relevant")
        self.present(next!, animated: true, completion: nil)
    }
    
    @IBAction func answerDButton(_ sender: UIButton) {
        QUOI_STATE.QUESTION_ANSWER = 3
        stopTimer()
        let next = self.storyboard?.instantiateViewController(withIdentifier: "Relevant")
        self.present(next!, animated: true, completion: nil)
    }
    
}
