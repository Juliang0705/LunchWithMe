//
//  LWMPostDetailViewController.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/28/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit

class LWMPostDetailViewController: UIViewController {

    
    var post:LWMPost?
    
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
    }
    
    func initGUI(){
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
