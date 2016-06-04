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

class SettingsViewController: UIViewController {

    @IBOutlet weak var epochOneValue: UITextField!
    @IBOutlet weak var epochTwoValue: UITextField!
    @IBOutlet weak var epochOneDate: UIDatePicker!
    @IBOutlet weak var epochTwoDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadUserDefaults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func loadUserDefaults() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var tmpValue: AnyObject?
        
        tmpValue = defaults.objectForKey("formulaCountdownEpochOneDate")
        if(tmpValue != nil) {
            epochOneDate.date = tmpValue as! NSDate
        }
        
        tmpValue = defaults.objectForKey("formulaCountdownEpochTwoDate")
        if(tmpValue != nil) {
            epochTwoDate.date = tmpValue as! NSDate
        }
        
        epochOneValue.text = String(defaults.doubleForKey("formulaCountdownEpochOneValue"))
        epochTwoValue.text = String(defaults.doubleForKey("formulaCountdownEpochTwoValue"))
        
    }
    
    @IBAction func saveUserDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(epochOneDate.date.earlierDate(epochTwoDate.date), forKey: "formulaCountdownEpochOneDate")
        defaults.setObject(epochOneDate.date.laterDate(epochTwoDate.date), forKey: "formulaCountdownEpochTwoDate")
        
        if(epochOneDate.date.earlierDate(epochTwoDate.date) == epochOneDate.date) {
            defaults.setDouble(NSString(string: epochOneValue.text!).doubleValue, forKey: "formulaCountdownEpochOneValue")
            defaults.setDouble(NSString(string: epochTwoValue.text!).doubleValue, forKey: "formulaCountdownEpochTwoValue")
        }
        else {
            defaults.setDouble(NSString(string: epochOneValue.text!).doubleValue, forKey: "formulaCountdownEpochTwoValue")
            defaults.setDouble(NSString(string: epochTwoValue.text!).doubleValue, forKey: "formulaCountdownEpochOneValue")
        }
        
    }
    
    @IBAction func saveSettings() {
        saveUserDefaults()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelSettings() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
