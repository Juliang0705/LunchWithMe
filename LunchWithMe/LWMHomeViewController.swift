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


var LWMSharedposts:[LWMPost]?

class LWMHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postViewMode: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initGUI()
        monitorLocation()
        LWMNotification.requestLocationUpdate()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updatePosts()
    }
    func initGUI(){
        tableView.dataSource = self
        tableView.delegate = self
        postViewMode.addTarget(self, action: "postViewModeDidChange:", forControlEvents: .ValueChanged)
    }
    
    func updatePosts(){
        if let location = LWMCurrentLocation{
            
            LWMPost.fetchFromParse(location, withinMiles: 20, completion: { (posts, error) -> () in
                if (error == nil){
                    print("Loading succeed with \(posts?.count) posts")
                    LWMSharedposts = posts
                    self.tableView.reloadData()
                }else{
                    print("Error: \(error)")
                }
            })
            
        }else{
            print("No data due to no location")
        }
    }
    
    func monitorLocation(){
        NSNotificationCenter.defaultCenter().addObserverForName(LWMNotification.LocationDidUpdate, object: nil, queue: NSOperationQueue.mainQueue()) {(notification) -> Void in
                self.updatePosts()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = LWMSharedposts{
            return posts.count
        }else{
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let LWMPostCell = tableView.dequeueReusableCellWithIdentifier("LWMPostTableViewCell", forIndexPath: indexPath) as! LWMPostTableViewCell
        LWMPostCell.post = LWMSharedposts![indexPath.row]
        return LWMPostCell
    }
    
    func postViewModeDidChange(segmentView: UISegmentedControl){
        print(segmentView.selectedSegmentIndex)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let postDetailViewController = segue.destinationViewController as? LWMPostDetailViewController{
            if let cell = sender as? LWMPostTableViewCell{
                postDetailViewController.post = cell.post
            }
        }
    }

}
