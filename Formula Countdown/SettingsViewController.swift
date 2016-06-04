//
//  SettingsViewController.swift
//  Formula Countdown
//
//  Created by Manu Bhardwaj on 6/3/16.
//  Copyright © 2016 Manu Bhardwaj. All rights reserved.
//

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
    
    @IBAction func validateEpochValues() {
        //epochOneValue.text =  String(format: "%.1f", epochOneValue.text!)
        //epochTwoValue.text = epochTwoValue.text
    
    }
    
    @IBAction func loadUserDefaults() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var tmpValue: AnyObject?
        
        tmpValue = defaults.objectForKey("formulaCountdownEpochOneValue")
        if(tmpValue != nil) {
            epochOneValue.text = tmpValue as? String
        }
        else {
            epochOneValue.text = "0"
        }
        
        tmpValue = defaults.objectForKey("formulaCountdownEpochOneDate")
        if(tmpValue != nil) {
            epochOneDate.date = tmpValue as! NSDate
        }
            
        tmpValue = defaults.objectForKey("formulaCountdownEpochTwoValue")
        if(tmpValue != nil) {
            epochTwoValue.text = tmpValue as? String
        }
        else {
            epochTwoValue.text = "100"
        }
        
        tmpValue = defaults.objectForKey("formulaCountdownEpochTwoDate")
        if(tmpValue != nil) {
            epochTwoDate.date = tmpValue as! NSDate
        }
        
        validateEpochValues()
    }
    
    @IBAction func saveUserDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(epochOneValue.text, forKey: "formulaCountdownEpochOneValue")
        defaults.setObject(epochOneDate.date, forKey: "formulaCountdownEpochOneDate")
        defaults.setObject(epochTwoValue.text, forKey: "formulaCountdownEpochTwoValue")
        defaults.setObject(epochTwoDate.date, forKey: "formulaCountdownEpochTwoDate")
    }
    
    @IBAction func saveSettings() {
        saveUserDefaults()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelSettings() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
