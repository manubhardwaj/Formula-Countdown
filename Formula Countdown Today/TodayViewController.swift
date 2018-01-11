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
    @IBOutlet weak var calorieLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        let epochOneValue: Double = 234
        let epochTwoValue: Double = 174.9
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let epochOneDate: Date = formatter.date(from:"2018-01-01")!
        let epochTwoDate: Date = formatter.date(from:"2018-11-04")!
        
        let currentDate: Date = Date()
        
        let tmpTotalTime = (epochTwoDate.timeIntervalSince1970 - epochOneDate.timeIntervalSince1970)
        let tmpElapsedTime = (currentDate.timeIntervalSince1970 - epochOneDate.timeIntervalSince1970)
        let tmpTotalValue: Double = epochOneValue + (epochTwoValue - epochOneValue)*tmpElapsedTime/tmpTotalTime
        
        let tmpSecondaryValue = 2400 - (tmpTotalValue - epochTwoValue)*3500/((tmpTotalTime - tmpElapsedTime)/60/60/24)
        
        mainLabel.text = String(format: "%.1f", tmpTotalValue)
        calorieLabel.text = String(format: "%.0f", tmpSecondaryValue)
        
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

        completionHandler(NCUpdateResult.newData)
    }
    
}
