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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func suggestAction(sender: AnyObject) {
        print("Hehe")
        //postToParse(post:LWMPost , completion:PFBooleanResultBlock?)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
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
