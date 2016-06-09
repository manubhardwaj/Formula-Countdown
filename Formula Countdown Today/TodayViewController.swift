//
//  TodayViewController.swift
//  Formula Countdown Today
//
//  Created by Manu Bhardwaj on 6/9/16.
//  Copyright © 2016 Manu Bhardwaj. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        let epochOneValue: Double = 231.5
        let epochTwoValue: Double = 173.8
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let epochOneDate: NSDate = formatter.dateFromString("2016-06-09 12:00:00 +0000")!
        let epochTwoDate: NSDate = formatter.dateFromString("2016-12-23 12:00:00 +0000")!
        
        let currentDate: NSDate = NSDate()
        
        let tmpTotalTime = (epochTwoDate.timeIntervalSince1970 - epochOneDate.timeIntervalSince1970)
        let tmpElapsedTime = (currentDate.timeIntervalSince1970 - epochOneDate.timeIntervalSince1970)
        let tmpTotalValue: Double = epochOneValue + (epochTwoValue - epochOneValue)*tmpElapsedTime/tmpTotalTime
        
        mainLabel.text = String(format: "%.1f", tmpTotalValue)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}