//
//  ViewController.swift
//  ZankFriday
//
//  Created by Thomas Kaczanko on 10/31/14.
//  Copyright (c) 2014 Zank. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var isItFridayTitle: UILabel!
    @IBOutlet weak var noResponse: UILabel!
    @IBOutlet weak var yesResponse: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian);
        let myComponents = myCalendar?.components([NSCalendar.Unit.weekday, NSCalendar.Unit.hour, NSCalendar.Unit.minute, NSCalendar.Unit.second], from: NSDate() as Date);
        
        let weekDay = myComponents?.weekday;
        let hours = myComponents?.hour;
        let minutes = myComponents?.minute;
        let seconds = myComponents?.second;
        
        if (weekDay == 6){
            Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(self.updateYes), userInfo: nil, repeats: true);
            
            yesResponse.alpha = 1;
            
            yesResponse.isHidden = false;
            noResponse.isHidden = true;
        }else{
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateNo), userInfo: nil, repeats: true);
            
            noResponse.alpha = 1;
            
            yesResponse.isHidden = true;
            noResponse.isHidden = false;
            
            setupFridayNotification(weekDay: weekDay!, hours: hours!, minutes: minutes!, seconds: seconds!);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func updateYes() {
        if (yesResponse.alpha >= 1){
            yesResponse.alpha = 0;
        }
        
        yesResponse.alpha += 0.1;
    }
    
    @objc func updateNo(){
        if (noResponse.alpha >= 1){
            noResponse.alpha = 0;
        }
        
        noResponse.alpha += 0.1;
    }
    
    func setupFridayNotification(weekDay: Int, hours: Int, minutes: Int, seconds: Int){
        var daysUntil = 0;
        
        if (weekDay == 7){
            daysUntil = 5;
        }else{
            daysUntil = 6 - weekDay - 1;
        }
        
        var hoursUntil = 24 - hours - 1;
        var minutesUntil = 60 - minutes - 1;
        let secondsUntil = 60 - seconds;
        
        // The notification will default to 12:00AM on the next Friday
        // 
        // You can add to the time to get the notification to be whatever time
        // you want during the day.
        //
        hoursUntil += 8; // 8 AM
        minutesUntil += 15; // 8:15 AM
        
        let f = TimeInterval ((daysUntil * 86400) + (hoursUntil * 3600) + (minutesUntil * 60) + secondsUntil);
        
        let whenWillFridayBeNow = NSDate(timeIntervalSinceNow:f);
        
        let localNotification:UILocalNotification = UILocalNotification();
        localNotification.alertAction = "Hey";
        localNotification.alertBody = "It's Friday, yo!";
        localNotification.fireDate = whenWillFridayBeNow as Date;
        UIApplication.shared.scheduleLocalNotification(localNotification);
    }
}

