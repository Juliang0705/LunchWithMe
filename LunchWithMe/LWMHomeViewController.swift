//
//  LWUHomeViewController.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/23/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import CoreLocation

class LWMHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserverForName(LWMNotification.LocationDidUpdate, object: nil, queue: NSOperationQueue.mainQueue()) {(notification) -> Void in
            let location = notification.userInfo![LWMNotification.LocationDidUpdate] as! CLLocation
            print(location)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
