//
//  GlanceController.swift
//  ZankFridayWatch Extension
//
//  Created by Thomas Kaczanko on 10/8/15.
//  Copyright © 2015 Zank. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {
    @IBOutlet var yesLabel: WKInterfaceLabel!;
    @IBOutlet var noLabel: WKInterfaceLabel!;
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate();
        
        //
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian);
        let myComponents = myCalendar?.components([NSCalendarUnit.NSWeekdayCalendarUnit, NSCalendarUnit.NSHourCalendarUnit, NSCalendarUnit.NSMinuteCalendarUnit, NSCalendarUnit.NSSecondCalendarUnit], fromDate: NSDate());
        
        let weekDay = myComponents?.weekday;
        
        if (weekDay == 6){
            noLabel.setHidden(true);
            yesLabel.setHidden(false);
        }else{
            noLabel.setHidden(false);
            yesLabel.setHidden(true);
        }

    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate();
        
        //Hide both when this goes away
        noLabel.setHidden(true);
        yesLabel.setHidden(true);
    }

}
