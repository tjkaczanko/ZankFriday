//
//  ZankFridayComplication.swift
//  ZankFriday
//
//  Created by Thomas Kaczanko on 10/8/15.
//  Copyright © 2015 Zank. All rights reserved.
//

import ClockKit

class ZankFridayComplication: NSObject, CLKComplicationDataSource {
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        // Call the handler with the current timeline entry
        var template: CLKComplicationTemplate? = nil
        
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian);
        let myComponents = myCalendar?.components([NSCalendarUnit.NSWeekdayCalendarUnit, NSCalendarUnit.NSHourCalendarUnit, NSCalendarUnit.NSMinuteCalendarUnit, NSCalendarUnit.NSSecondCalendarUnit], fromDate: NSDate());
        
        let weekDay = myComponents?.weekday;
        
        if complication.family == .ModularSmall {
            let modularTemplate = CLKComplicationTemplateModularSmallStackText();
            
            modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "Fri?");
            
            if (weekDay == 6){
                modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: "Yes");
            }else{
                modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: "No");
            }

            template = modularTemplate;
            
            let timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template!)
            handler(timelineEntry)
        } else if complication.family == .ModularLarge {
            let modularTemplate = CLKComplicationTemplateModularLargeTallBody();
            
            modularTemplate.headerTextProvider = CLKSimpleTextProvider(text: "Is it Friday?");
            
            if (weekDay == 6){
                modularTemplate.bodyTextProvider = CLKSimpleTextProvider(text: "Yes");
            }else{
                modularTemplate.bodyTextProvider = CLKSimpleTextProvider(text: "No");
            }
            
            template = modularTemplate;
            
            let timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template!)
            handler(timelineEntry)
        } else if complication.family == .UtilitarianSmall {
            let modularTemplate = CLKComplicationTemplateUtilitarianSmallRingText();
            
            if (weekDay == 6){
                modularTemplate.textProvider = CLKSimpleTextProvider(text: "Yes");
                modularTemplate.fillFraction = 1.0;
            }else{
                modularTemplate.textProvider = CLKSimpleTextProvider(text: "No");
                modularTemplate.fillFraction = 0.0;
            }
            
            template = modularTemplate;
            
            let timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template!)
            handler(timelineEntry)

        } else if complication.family == .UtilitarianLarge {
            let modularTemplate = CLKComplicationTemplateUtilitarianLargeFlat();
            
            if (weekDay == 6){
                modularTemplate.textProvider = CLKSimpleTextProvider(text: "It is Friday!");
            }else{
                modularTemplate.textProvider = CLKSimpleTextProvider(text: "Not Friday...");
            }
            
            template = modularTemplate;
            
            let timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template!)
            handler(timelineEntry)
        } else if complication.family == .CircularSmall {
            let template = CLKComplicationTemplateCircularSmallRingText()
            
            if (weekDay == 6){
                template.textProvider = CLKSimpleTextProvider(text: "Yes")
                template.fillFraction = 1.0
            }else{
                template.textProvider = CLKSimpleTextProvider(text: "No")
                template.fillFraction = 0.0
            }
            
            template.ringStyle = CLKComplicationRingStyle.Closed
            
            let timelineEntry = CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: template)
            handler(timelineEntry)
        } else {
            handler(nil)
        }
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(NSDate(timeIntervalSinceNow: 5))
    }
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        var template: CLKComplicationTemplate? = nil
        switch complication.family {
        case .ModularSmall:
            let modularTemplate = CLKComplicationTemplateModularSmallStackText();
            modularTemplate.line1TextProvider = CLKSimpleTextProvider(text: "Fri?");
            modularTemplate.line2TextProvider = CLKSimpleTextProvider(text: "????");
            template = modularTemplate;
        case .ModularLarge:
            let modularTemplate = CLKComplicationTemplateModularLargeTallBody();
            modularTemplate.headerTextProvider = CLKSimpleTextProvider(text: "Is it Friday?");
            modularTemplate.bodyTextProvider = CLKSimpleTextProvider(text: "????????????");
            template = modularTemplate;
        case .UtilitarianSmall:
            let modularTemplate = CLKComplicationTemplateUtilitarianSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "y/n")
            modularTemplate.fillFraction = 1.0
            modularTemplate.ringStyle = CLKComplicationRingStyle.Closed
            template = modularTemplate
        case .UtilitarianLarge:
            let modularTemplate = CLKComplicationTemplateUtilitarianLargeFlat();
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "Is it Friday?");
            template = modularTemplate;
        case .CircularSmall:
            let modularTemplate = CLKComplicationTemplateCircularSmallRingText()
            modularTemplate.textProvider = CLKSimpleTextProvider(text: "y/n")
            modularTemplate.fillFraction = 1.0
            modularTemplate.ringStyle = CLKComplicationRingStyle.Closed
            template = modularTemplate
        }
        handler(template)
    }
    
}
