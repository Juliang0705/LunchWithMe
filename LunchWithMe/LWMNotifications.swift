//
//  LWMNotifications.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/24/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import Foundation

class LWMNotification{
    static let LocationDidUpdate = "LocationDidUpdate"
    static let UserDidLogOut = "UserDidLogOut"
    static let LocationNeedUpdate = "LocationNeedUpdate"
    class func requestLocationUpdate(){
        NSNotificationCenter.defaultCenter().postNotificationName(LWMNotification.LocationNeedUpdate, object: self)
    }
}