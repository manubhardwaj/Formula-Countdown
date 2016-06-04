//
//  ViewController.swift
//  Formula Countdown
//
//  Created by Manu Bhardwaj on 9/26/15.
//  Copyright © 2015 Manu Bhardwaj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainDate: UIDatePicker!
    @IBOutlet weak var mainLabel: UILabel!
    
    var m_startDate: NSDate = NSDate()
    var m_endDate: NSDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        m_startDate = dateFormatter.dateFromString("2016-06-04T00:00:00Z")!
        m_endDate = dateFormatter.dateFromString("2016-12-23T00:00:00Z")!
        
        mainDate.minimumDate = m_startDate
        mainDate.maximumDate = m_endDate
        
        mainDateChanged(mainDate)
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mainDateChanged(sender: UIDatePicker) {
        
        let tmpTotalTime = (m_endDate.timeIntervalSince1970 - m_startDate.timeIntervalSince1970)
        
        let tmpElapsedTime = (mainDate.date.timeIntervalSince1970 - m_startDate.timeIntervalSince1970)
        
        let tmpHighValue: Double = 100
        let tmpLowValue: Double = 0
        
        let tmpTotalValue: Double = tmpHighValue - (tmpHighValue - tmpLowValue)*tmpElapsedTime/tmpTotalTime
        
        mainLabel.text = String(format: "%.1f", tmpTotalValue)
        
        
    }

}

