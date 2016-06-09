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
    
    @IBOutlet weak var mainDate: UIDatePicker!
    @IBOutlet weak var mainLabel: UILabel!
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SettingsViewController" {
            let tmpSettingsViewController = segue.destinationViewController as? SettingsViewController
            if let tmpViewController = tmpSettingsViewController {
                tmpViewController.m_delegate = self
                tmpViewController.m_currentDate = self.m_currentDate
            }
        }
    }
    
    func refreshSettings(controller: SettingsViewController, currentDate: NSDate, epochOneDate: NSDate, epochTwoDate: NSDate, epochOneValue: Double, epochTwoValue: Double) {
        m_currentDate = currentDate
        m_epochOneDate = epochOneDate
        m_epochTwoDate = epochTwoDate
        m_epochOneValue = epochOneValue
        m_epochTwoValue = epochTwoValue
        
        mainDateChanged()
    }
    
    @IBAction func loadUserDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()

        if let tmpDateOne = defaults.objectForKey("formulaCountdownEpochOneDate") {
            m_epochOneDate = tmpDateOne as! NSDate
        }
        if let tmpDateTwo = defaults.objectForKey("formulaCountdownEpochTwoDate") {
            m_epochTwoDate = tmpDateTwo as! NSDate
        }
        m_epochOneValue = defaults.doubleForKey("formulaCountdownEpochOneValue")
        m_epochTwoValue = defaults.doubleForKey("formulaCountdownEpochTwoValue")

    }
    
    @IBAction func mainDateChanged() {
        let tmpTotalTime = (m_epochTwoDate.timeIntervalSince1970 - m_epochOneDate.timeIntervalSince1970)
        let tmpElapsedTime = (m_currentDate.timeIntervalSince1970 - m_epochOneDate.timeIntervalSince1970)
        let tmpTotalValue: Double = m_epochOneValue + (m_epochTwoValue - m_epochOneValue)*tmpElapsedTime/tmpTotalTime
        mainLabel.text = String(format: "%.1f", tmpTotalValue)
    }

}

