//
//  LWUHomeViewController.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/23/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import CoreLocation
import Parse

class LWMHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var posts:[LWMPost]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGUI()
        monitorLocation()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updatePosts()
    }
    func initGUI(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func updatePosts(){
        if let location = LWMCurrentLocation{
            
            LWMPost.fetchFromParse(location, withinMiles: 20, completion: { (posts, error) -> () in
                if (error == nil){
                    print("Loading succeed with \(posts?.count) posts")
                    self.posts = posts
                    self.tableView.reloadData()
                }else{
                    print("Error: \(error)")
                }
            })
            
        }
    }
    
    func monitorLocation(){
        NSNotificationCenter.defaultCenter().addObserverForName(LWMNotification.LocationDidUpdate, object: nil, queue: NSOperationQueue.mainQueue()) {(notification) -> Void in
            
         //   let location = notification.userInfo![LWMNotification.LocationDidUpdate] as! CLLocation
            self.updatePosts()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts{
            return posts.count
        }else{
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let LWMPostCell = tableView.dequeueReusableCellWithIdentifier("LWMPostTableViewCell", forIndexPath: indexPath) as! LWMPostTableViewCell
        let post = posts![indexPath.row]
        if post.anonymous{
            LWMPostCell.username.text = "Anonymous"
        }else{
            LWMPostCell.username.text = post.lwmUser.username!
        }
        LWMPostCell.location.text = post.address
        LWMPostCell.foodPlace.text = post.foodPlace
        LWMPostCell.time.text = post.time
        
        return LWMPostCell
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
