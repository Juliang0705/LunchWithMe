//
//  LWMPostDetailViewController.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/28/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit

class LWMPostDetailViewController: UIViewController,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{

    
    var post:LWMPost?
    
    @IBOutlet weak var commentContainerView: UIView!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBOutlet weak var commentWordCount: UILabel!
    @IBOutlet weak var commentAnonSwitch: UISwitch!
    @IBOutlet weak var postCommentTableView: UITableView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var foodPlace: UILabel!
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak  var createdTime: UILabel!

    @IBOutlet weak var detail: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGUI()
        if let post = post{
            for comment in post.postComments{
                if (try? comment.lwmUser.fetchIfNeeded()) == nil{
                    print("fetching LWMUser failed")
                }
            }
        }
        postCommentTableView.reloadData()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.hidden = false
    }
    
    func initGUI(){
        
        // set up post labels
        if let post = post{
            if post.anonymous{
                username.text = "Anonymous"
            }else{
                username.text = post.lwmUser.username!
            }
            location.text = post.address
            foodPlace.text = post.foodPlace
            time.text = post.time
            createdTime.text = post.createdAt!.shortDate
            detail.text = post.detail
        }
        
        //set up text field
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        commentTextField.delegate = self
        
        //add notification listener for keyboard event
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "KeyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "KeyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        //set up table view
        postCommentTableView.delegate = self
        postCommentTableView.dataSource = self
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newLength:Int = (textField.text! as NSString).length + (string as NSString).length - range.length
        let remainingChar:Int = 100 - newLength
        commentWordCount.text = "\(remainingChar)"
        return (newLength < 100)
    }
    
    func KeyboardWillShow(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
            self.view.frame.origin.y -= 40
        }
    }
    
    func KeyboardWillHide(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
            self.view.frame.origin.y += 40
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let post = self.post{
            return post.postComments.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let LWMCommentCell = tableView.dequeueReusableCellWithIdentifier("LWMPostCommentTableViewCell", forIndexPath: indexPath) as! LWMPostCommentTableViewCell
        LWMCommentCell.postComment = post!.postComments[indexPath.row]
        return LWMCommentCell
    }
    
    @IBAction func sendButtonClicked(sender: UIButton) {
        post?.postComments.append(LWMPostComment(isAnonymous: commentAnonSwitch.on, comment: commentTextField.text!))
        post?.saveInBackgroundWithBlock({ (success, error) -> Void in
            if error == nil{
                print("Adding Comment Succeeded")
                self.dismissKeyboard()
                self.commentTextField.text = ""
                self.commentWordCount.text = "100"
                self.postCommentTableView.reloadData()
            }else{
                print(error)
            }
        })
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
