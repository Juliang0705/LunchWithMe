//
//  LWUTabBarController.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/22/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import Parse

class LWMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    func setUpTabs(){
        let homeScreenNavigationController = mainStoryboard.instantiateViewControllerWithIdentifier("LWMHome") as? UINavigationController
        
        let homeScreenViewController = homeScreenNavigationController?.topViewController
        homeScreenViewController?.title = "Home"
        
        homeScreenNavigationController?.tabBarItem.title = "Home"
     //   homeScreenViewController?.tabBarItem.image = UIImage(named: "home")
//        //------------------------------------------------------------------------------
//        let searchNavigationController = mainStoryboard.instantiateViewControllerWithIdentifier("Search") as? UINavigationController
//        
//        let searchViewController = searchNavigationController?.topViewController
//        searchViewController?.title = "Search"
//        
//        searchNavigationController?.tabBarItem.title = "Search"
//        searchNavigationController?.tabBarItem.image = UIImage(named: "search")
//        //------------------------------------------------------------------------------
//        
//        let cameraNavigationController = mainStoryboard.instantiateViewControllerWithIdentifier("Camera") as? UINavigationController
//        
//        let cameraViewController = cameraNavigationController?.topViewController
//        cameraViewController?.title = "Upload"
//        
//        cameraNavigationController?.tabBarItem.title = "Upload"
//        cameraNavigationController?.tabBarItem.image = UIImage(named: "upload")
//        //------------------------------------------------------------------------------
//        
//        let activityNavigationController = mainStoryboard.instantiateViewControllerWithIdentifier("Activity") as? UINavigationController
//        
//        let activityViewController = activityNavigationController?.topViewController
//        activityViewController?.title = "Activity"
//        
//        activityNavigationController?.tabBarItem.title = "Activity"
//        activityNavigationController?.tabBarItem.image = UIImage(named: "activity")
//        
//        //------------------------------------------------------------------------------
        
        let userNavigationController = mainStoryboard.instantiateViewControllerWithIdentifier("LWMUser") as? UINavigationController
        
        let userViewController = userNavigationController?.topViewController
        userViewController?.title = "Me"
        
        userNavigationController?.tabBarItem.title = "User"
     //   userNavigationController?.tabBarItem.image = UIImage(named: "user")
        //------------------------------------------------------------------------------
        
        let mapNavigationController = mainStoryboard.instantiateViewControllerWithIdentifier("LWMMap") as? UINavigationController
        let mapViewController = userNavigationController?.topViewController
        mapViewController?.title = "Map"
        
        mapNavigationController?.tabBarItem.title = "Map"
        
        self.viewControllers = [homeScreenNavigationController!,mapNavigationController!,userNavigationController!]
        
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
