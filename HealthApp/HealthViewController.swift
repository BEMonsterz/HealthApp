//
//  HealthViewController.swift
//  HealthApp
//
//  Created by Bryan Ayllon on 7/15/16.
//  Copyright © 2016 Bryan Ayllon. All rights reserved.
//

import UIKit
import CoreMotion

class HealthViewController: UIViewController {
    
    var pedometer = CMPedometer()
    @IBOutlet weak var labelForSteps :UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pedometer = CMPedometer()
        self.pedometer.startPedometerUpdatesFromDate(NSDate()) { (data :CMPedometerData?, error :NSError?) in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dataButtonWasPressed(){
        let whiteView = UIView(frame: CGRectMake(0,450,450,250))
        whiteView.backgroundColor = UIColor(red:255/255, green:255/255, blue:255/255, alpha:1.00)
        self.view.addSubview(whiteView)
       
        
        
    for day in 1...7 {
            let calendar = NSCalendar.currentCalendar()
            guard let startDate = calendar.dateByAddingUnit(.Day, value: -1 * day, toDate: NSDate(), options: []) else {
                fatalError("Date not detected!")
            }
            
            let X = 60
            let barXPostion = (X * day) - 55
            print(barXPostion)
            
            self.pedometer.queryPedometerDataFromDate(startDate, toDate: NSDate()) { (data :CMPedometerData?, error :NSError?) in
                
                if let data = data {
                    let numberOfSteps = data.numberOfSteps
                    let dataOfSteps = Double(numberOfSteps)
                    let negativeNumber = (dataOfSteps * -1) / 130
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        let bar = UIView(frame: CGRectMake(CGFloat(barXPostion),250,45,CGFloat(negativeNumber)))
                        bar.backgroundColor = UIColor(red:126/255, green:87/255, blue:250/255, alpha:1.00)

                        whiteView.addSubview(bar)
                        
                        let stepValueNumber = UILabel(frame: CGRectMake(CGFloat(barXPostion),0,100,100))
                        stepValueNumber.text = String(format:"%.0f",dataOfSteps)
                        whiteView.addSubview(stepValueNumber)
                        
                    })
                }
            }
        }
    }
}