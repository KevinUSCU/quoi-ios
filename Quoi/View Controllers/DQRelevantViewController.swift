//
//  DQRelevantViewController.swift
//  Quoi
//
//  Created by Kevin Springer on 1/28/18.
//  Copyright © 2018 Kevin Springer. All rights reserved.
//

import UIKit

class DQRelevantViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    // MARK: View Buttons
    
    @IBAction func thumbsUpButton(_ sender: UIButton) {
        QUOI_STATE.QUESTION_WAS_RELEVANT = true
        let next = self.storyboard?.instantiateViewController(withIdentifier: "DQ Answer")
        self.present(next!, animated: true, completion: nil)
    }
    
    @IBAction func thumbsDownButton(_ sender: UIButton) {
        QUOI_STATE.QUESTION_WAS_RELEVANT = false
        let next = self.storyboard?.instantiateViewController(withIdentifier: "DQ Answer")
        self.present(next!, animated: true, completion: nil)
    }
    
}
