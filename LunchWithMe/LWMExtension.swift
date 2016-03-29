//
//  LWMExtension.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/28/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import Foundation

extension NSDateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}

extension NSDate {
    struct Date {
        static let formatterShortDate = NSDateFormatter(dateFormat: "HH:mm  MMM dd ,yyyy")
    }
    var shortDate: String {
        return Date.formatterShortDate.stringFromDate(self)
    }
    var timePassedSinceCreated: String{
        let number = Int(NSDate().timeIntervalSinceDate(self))
        let day = number/86400
        let hour = (number - day * 86400)/3600
        let minute = (number - day * 86400 - hour * 3600)/60
        if day != 0{
            return String(day) + "d"
        }else if hour != 0 {
            return String(hour) + "h"
        }else{
            return String(minute) + "m"
        }
    }
}
