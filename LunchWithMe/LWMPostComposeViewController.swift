//
//  LWMPostComposeViewController.swift
//  LunchWithMe
//
//  Created by Santos Solorzano on 3/24/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import Parse

class LWMPostComposeViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var foodPlace: UITextField!
    
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var detail: UITextField!
    
    @IBOutlet weak var anonSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGUI()
    }
    
    func initGUI(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        foodPlace.delegate = self
        address.delegate = self
        time.delegate = self
        detail.delegate = self
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func postAction(sender: UIButton) {
        let post = LWMPost(user: PFUser.currentUser()!, loc: LWMCurrentLocation!, placeName: foodPlace.text!,addr: address.text!, when: time.text!, description: detail.text!, isAnonymous: anonSwitch.on, comments: [])
        post.saveInBackgroundWithBlock { (success, error) -> Void in
            if (success){
                print("Posting succeeded")
            }else{
                print("Posting failed\n\(error)")
            }
        }
        onCancel(self)
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
