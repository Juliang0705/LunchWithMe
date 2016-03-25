//
//  LWMPostComposeViewController.swift
//  LunchWithMe
//
//  Created by Santos Solorzano on 3/24/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import Parse

class LWMPostComposeViewController: UIViewController {
    
    var post: LWMPost?
    var user: LWMUser?
    var location: PFGeoPoint?
    var foodPlace: String?
    var detail: String?
    var anonymous: Bool?
    var postComments: [LWMPostComment]?
    var timeText: String?
    
    @IBOutlet weak var anonSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.post?.foodPlace = "Cane's"
        self.post?.detail = "Cane's"
        self.post?.postComments = []
        self.post?.time = "12 PM"
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        anonSwitch.addTarget(self, action: Selector("anonState:"), forControlEvents: UIControlEvents.ValueChanged)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func suggestAction(sender: AnyObject) {
        print("Hehe")
        LWMPost.postToParse(post!) { (flag: Bool, error: NSError?) -> Void in
            if error == nil {
                print("LWMPost was successful!")
            }
            else {
                print("error occurred \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    @IBAction func anonState(sender: AnyObject) {
        if anonSwitch.on {
            print("I AM ON")
            self.post!.anonymous = true
        } else {
            print("I AM OFF")
            self.post!.anonymous = false
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
