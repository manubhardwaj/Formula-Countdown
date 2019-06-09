//
//  ViewController.swift
//  Formula Countdown
//
//  Created by Manu Bhardwaj on 9/26/15.
//  Copyright © 2015 Manu Bhardwaj.
/*
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import UIKit

class ViewController: UIViewController, SettingsViewControllerDelegate {
    func refreshSettings(controller: SettingsViewController, currentDate: NSDate, epochOneDate: NSDate, epochTwoDate: NSDate, epochOneValue: Double, epochTwoValue: Double) {
        m_currentDate = currentDate
        m_epochOneDate = epochOneDate
        m_epochTwoDate = epochTwoDate
        m_epochOneValue = epochOneValue
        m_epochTwoValue = epochTwoValue
        
        mainDateChanged()
    }
    
    
    @IBOutlet weak var mainDate: UIDatePicker!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    
    var m_currentDate: NSDate = NSDate()
    var m_epochOneDate: NSDate = NSDate()
    var m_epochTwoDate: NSDate = NSDate()
    var m_epochOneValue: Double = 0
    var m_epochTwoValue: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserDefaults()
        mainDateChanged()
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SettingsViewController" {
            let tmpSettingsViewController = segue.destination as? SettingsViewController
            if let tmpViewController = tmpSettingsViewController {
                tmpViewController.m_delegate = self
                tmpViewController.m_currentDate = self.m_currentDate as Date
            }
        }
    }
    
    @IBAction func loadUserDefaults() {
        
        let defaults = UserDefaults.standard

        if let tmpDateOne = defaults.object(forKey: "formulaCountdownEpochOneDate") {
            m_epochOneDate = tmpDateOne as! NSDate
        }
        if let tmpDateTwo = defaults.object(forKey: "formulaCountdownEpochTwoDate") {
            m_epochTwoDate = tmpDateTwo as! NSDate
        }

        m_epochOneValue = defaults.double(forKey: "formulaCountdownEpochOneValue")
        m_epochTwoValue = defaults.double(forKey: "formulaCountdownEpochTwoValue")

    }
    
    @IBAction func mainDateChanged() {
        
        let tmpTotalTime = (m_epochTwoDate.timeIntervalSince1970 - m_epochOneDate.timeIntervalSince1970)
        let tmpElapsedTime = (m_currentDate.timeIntervalSince1970 - m_epochOneDate.timeIntervalSince1970)
        
        var tmpTotalValue: Double = m_epochOneValue + (m_epochTwoValue - m_epochOneValue)*tmpElapsedTime/tmpTotalTime
        var tmpSecondaryValue = 2350 - (tmpTotalValue - m_epochTwoValue)*3500/((tmpTotalTime - tmpElapsedTime)/60/60/24)
        
        if(tmpTotalValue.isNaN) {
            tmpTotalValue = 0.0
        }
        if(tmpSecondaryValue.isNaN) {
            tmpSecondaryValue = 0.0
        }
        
        mainLabel.text = String(format: "%.1f", tmpTotalValue)
        secondaryLabel.text = String(format: "%.0f", tmpSecondaryValue)

    }

}

