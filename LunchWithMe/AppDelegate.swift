//
//  AppDelegate.swift
//  LunchWithMe
//
//  Created by Juliang Li on 2/1/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
var LWMCurrentLocation: CLLocation?
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {

    var window: UIWindow?

    let locationManager = CLLocationManager()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        initParse()
        initLocationManager()
        detectCurrentUser()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogOut", name: LWMNotification.UserDidLogOut, object: nil)
        return true
    }
    
    func userDidLogOut(){
        let signInViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LWMLogIn") as! LWMSignInViewController
        window?.rootViewController = signInViewController
    }
    
    func initParse(){
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "e4dfrt67gvrctbvtf"
                configuration.clientKey = "kjfadk3324fads"
                configuration.server = "https://lunchwithme1.herokuapp.com/parse"
            })
        )
    }
    
    func detectCurrentUser(){
        if PFUser.currentUser() != nil {
            print("Detect current User: \(PFUser.currentUser()!.username!)")
            let tabViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LWUTab") as! LWMTabBarController
            window?.rootViewController = tabViewController
            window?.makeKeyAndVisible()
        }
    }
    
    func initLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let interval:NSTimeInterval = location.timestamp.timeIntervalSinceNow
        if abs(interval) < 60{
            LWMCurrentLocation = location
            NSNotificationCenter.defaultCenter().postNotificationName(LWMNotification.LocationDidUpdate, object: self, userInfo: [LWMNotification.LocationDidUpdate:location])
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        locationManager.stopUpdatingLocation()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        locationManager.startUpdatingLocation()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

