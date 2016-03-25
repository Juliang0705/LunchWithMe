//
//  LWUUserViewController.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/23/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import Parse

class LWMUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSuggest(sender: AnyObject) {
        self.performSegueWithIdentifier("userSuggestSegue", sender: self)
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName("userDidLogoutNotification", object: nil)
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
