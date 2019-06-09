//
//  SettingsViewController.swift
//  Formula Countdown
//
//  Created by Manu Bhardwaj on 6/3/16.
//  Copyright © 2016 Manu Bhardwaj.
/*
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import UIKit

protocol SettingsViewControllerDelegate {
    func refreshSettings(controller: SettingsViewController, currentDate: NSDate, epochOneDate: NSDate, epochTwoDate: NSDate, epochOneValue: Double, epochTwoValue: Double)
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var epochOneValue: UITextField!
    @IBOutlet weak var epochTwoValue: UITextField!
    @IBOutlet weak var epochOneDate: UIDatePicker!
    @IBOutlet weak var epochTwoDate: UIDatePicker!
    @IBOutlet weak var currentDate: UIDatePicker!
        
    var m_delegate: SettingsViewControllerDelegate?
    var m_currentDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tmpCurrentDate = m_currentDate {
            currentDate.date = tmpCurrentDate
        }
        
        loadUserDefaults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func userTappedBackground(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func loadUserDefaults() {
        
        let defaults = UserDefaults.standard
        var tmpValue: Date?
        
        tmpValue = defaults.object(forKey:"formulaCountdownEpochOneDate") as! Date?
        if(tmpValue != nil) {
            epochOneDate.date = tmpValue as Date
        }
        
        tmpValue = defaults.object(forKey:"formulaCountdownEpochTwoDate") as! Date?
        if(tmpValue != nil) {
            epochTwoDate.date = tmpValue as Date
        }
        
        epochOneValue.text = String(defaults.double(forKey:"formulaCountdownEpochOneValue"))
        epochTwoValue.text = String(defaults.double(forKey:"formulaCountdownEpochTwoValue"))
    }
    
    @IBAction func saveSettings() {
        
        // Save User Defaults
        let defaults = UserDefaults.standard
        
        defaults.set((epochOneDate.date < epochTwoDate.date) ? epochOneDate.date : epochTwoDate.date, forKey: "formulaCountdownEpochOneDate")
        defaults.set((epochOneDate.date > epochTwoDate.date) ? epochOneDate.date : epochTwoDate.date, forKey: "formulaCountdownEpochTwoDate")
        
        if(epochOneDate.date < epochTwoDate.date) {
            defaults.set(NSString(string: epochOneValue.text!).doubleValue, forKey: "formulaCountdownEpochOneValue")
            defaults.set(NSString(string: epochTwoValue.text!).doubleValue, forKey: "formulaCountdownEpochTwoValue")
        }
        else {
            defaults.set(NSString(string: epochOneValue.text!).doubleValue, forKey: "formulaCountdownEpochTwoValue")
            defaults.set(NSString(string: epochTwoValue.text!).doubleValue, forKey: "formulaCountdownEpochOneValue")
        }
        
        // Assign Delegate
        if let delegate = m_delegate {
            delegate.refreshSettings(controller: self,
                                     currentDate: currentDate.date as NSDate,
                                     epochOneDate: epochOneDate.date as NSDate,
                                     epochTwoDate: epochTwoDate.date as NSDate,
                                    epochOneValue: NSString(string: epochOneValue.text!).doubleValue,
                                    epochTwoValue: NSString(string: epochTwoValue.text!).doubleValue)
        }
        
        // Close Window
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelSettings() {
        // Close Window
        dismiss(animated: true, completion: nil)
    }
}
