//
//  LWMPostComposeViewController.swift
//  LunchWithMe
//
//  Created by Santos Solorzano on 3/24/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import Mapbox
import Parse

class LWMPostComposeViewController: UIViewController, UITextFieldDelegate {
    
    var selectedAnnotation: MGLAnnotation?
    
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
        address.text = "\((selectedAnnotation!.title!)!), \((selectedAnnotation!.subtitle!)!)"
        
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        //self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func postAction(sender: UIButton) {
        let selectedLocation = CLLocation(latitude: selectedAnnotation!.coordinate.latitude, longitude: selectedAnnotation!.coordinate.longitude)
        let post = LWMPost(user: PFUser.currentUser()!, loc: selectedLocation, placeName: foodPlace.text!,addr: address.text!, when: time.text!, description: detail.text!, isAnonymous: anonSwitch.on, comments: [])
        post.saveInBackgroundWithBlock { (success, error) -> Void in
            if (success){
                print("Posting succeeded")
            }else{
                print("Posting failed\n\(error)")
            }
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
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
