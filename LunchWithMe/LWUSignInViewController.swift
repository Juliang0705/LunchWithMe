//
//  LWUSignInViewController.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/21/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import Parse


class LWUSignInViewController: UIViewController ,UITextFieldDelegate{

    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var anonymousButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGUI()
        // Do any additional setup after loading the view.
    }
    
    func initGUI(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        passwordTextField.secureTextEntry = true
        signInButton.layer.cornerRadius = 10
        signUpButton.layer.cornerRadius = 10
        passwordTextField.delegate = self
        usernameTextField.delegate = self
    }
    
    @IBAction func signInAction(sender: UIButton) {
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                showWarningViewWithMessage(error.localizedDescription, title: error.localizedFailureReason, parentViewController: self)
            } else {
                print("User logged in successfully")
                //@todo: change identifier
                self.performSegueWithIdentifier("LWUSignIn", sender: self)
            }
        }
    }
    
    
    @IBAction func signUpAction(sender: UIButton) {
        let newUser = PFUser()
        
        if (usernameTextField.text! == "" || passwordTextField.text! == ""){
            showWarningViewWithMessage("Fields cannot be empty", title: "Error", parentViewController: self)
            return
        }
        
        
        // set user properties
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        // call sign up function on the object
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                showWarningViewWithMessage(error.localizedDescription, title: error.localizedFailureReason, parentViewController: self)
                print(error.localizedFailureReason)
            } else {
                print("User Registered successfully")
                self.signInAction(self.signUpButton)
            }
        }
    }
    
    @IBAction func anonymousAction(sender: UIButton) {
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}

