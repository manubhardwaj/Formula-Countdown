//
//  ViewController.swift
//  Formula Countdown
//
//  Created by Manu Bhardwaj on 9/26/15.
//  Copyright © 2015 Manu Bhardwaj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var mainValue: UITextField!
    @IBOutlet weak var mainDate: UIDatePicker!
    
    @IBAction func mainDateChanged(sender: UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let tmpStartDate = dateFormatter.dateFromString("2016-06-04T00:00:00Z")
        let tmpEndDate = dateFormatter.dateFromString("2016-12-23T00:00:00Z")
        
        let tmpTotalTime = (tmpEndDate!.timeIntervalSince1970 - tmpStartDate!.timeIntervalSince1970)
        
        let tmpElapsedTime = (mainDate.date.timeIntervalSince1970 - tmpStartDate!.timeIntervalSince1970)
        
        let totalValue = 230.8 - (230.8-173.8)*tmpElapsedTime/tmpTotalTime
        
        mainValue.text = String(totalValue, "%.1f")
        
    }

    @IBAction func mainDateValueChanged(sender: UITextField) {
        
    }
}

