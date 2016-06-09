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
        
        let m_currentDate: NSDate = NSDate()
        var m_epochOneDate: NSDate = NSDate()
        var m_epochTwoDate: NSDate = NSDate()
        var m_epochOneValue: Double = 0
        var m_epochTwoValue: Double = 0
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let tmpDateOne = defaults.objectForKey("formulaCountdownEpochOneDate") {
            m_epochOneDate = tmpDateOne as! NSDate
        }
        if let tmpDateTwo = defaults.objectForKey("formulaCountdownEpochTwoDate") {
            m_epochTwoDate = tmpDateTwo as! NSDate
        }
        m_epochOneValue = defaults.doubleForKey("formulaCountdownEpochOneValue")
        m_epochTwoValue = defaults.doubleForKey("formulaCountdownEpochTwoValue")
        
        let tmpTotalTime = (m_epochTwoDate.timeIntervalSince1970 - m_epochOneDate.timeIntervalSince1970)
        let tmpElapsedTime = (m_currentDate.timeIntervalSince1970 - m_epochOneDate.timeIntervalSince1970)
        var tmpTotalValue: Double = m_epochOneValue + (m_epochTwoValue - m_epochOneValue)*tmpElapsedTime/tmpTotalTime
        
        if(tmpTotalValue.isNaN) {
            tmpTotalValue = 0.0
        }
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
