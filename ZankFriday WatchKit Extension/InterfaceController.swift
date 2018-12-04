//
//  InterfaceController.swift
//  ZankFriday WatchKit Extension
//
//  Created by Thomas Kaczanko on 4/2/15.
//  Copyright (c) 2015 Zank. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var yesLabel: WKInterfaceLabel!;
    @IBOutlet weak var noLabel: WKInterfaceLabel!;
    
    var yesAlpha:CGFloat = 1;
    var noAlpha:CGFloat = 1;
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate();
        
        var myCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar);
        var myComponents = myCalendar?.components(NSCalendarUnit.WeekdayCalendarUnit|NSCalendarUnit.HourCalendarUnit|NSCalendarUnit.MinuteCalendarUnit|NSCalendarUnit.SecondCalendarUnit, fromDate: NSDate());
        
        var weekDay = myComponents?.weekday;
        var hours = myComponents?.hour;
        var minutes = myComponents?.minute;
        var seconds = myComponents?.second;
        
        if (weekDay == 6){
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateYes"), userInfo: nil, repeats: true);
            
            yesLabel.setAlpha(yesAlpha);
            
            yesLabel.setHidden(false);
            noLabel.setHidden(true);
        }else{
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateNo"), userInfo: nil, repeats: true);
        
            noLabel.setAlpha(noAlpha);
            
            yesLabel.setHidden(true);
            noLabel.setHidden(false);
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate();
    }
    
    func updateYes() {
        
        if (yesAlpha >= 1){
            yesAlpha = 0;
            yesLabel.setAlpha(yesAlpha);
            return;
        }
        
        yesAlpha += 0.1;
        yesLabel.setAlpha(yesAlpha);
    }
    
    func updateNo(){
        if (noAlpha >= 1){
            noAlpha = 0;
            noLabel.setAlpha(noAlpha);
            return;
        }
        
        noAlpha += 0.1;
        noLabel.setAlpha(noAlpha);
    }

}
