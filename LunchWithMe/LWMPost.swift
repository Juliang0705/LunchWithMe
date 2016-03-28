//
//  LWUPost.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/23/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import Foundation
import Parse

class LWMPost: PFObject, PFSubclassing{
    @NSManaged var lwmUser:PFUser
    @NSManaged var location: PFGeoPoint
    @NSManaged var foodPlace: String
    @NSManaged var detail: String
    @NSManaged var anonymous: Bool
    @NSManaged var postComments: [LWMPostComment]
    @NSManaged var time: String
    
    override init() {
        super.init()
    }
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    static func parseClassName() -> String{
        return "LWMPost"
    }

    
    init(user: PFUser, loc: PFGeoPoint, place: String,when: String, description: String,isAnonymous: Bool,comments: [LWMPostComment]){
        super.init()
        lwmUser = user
        location = loc
        foodPlace = place
        detail = description
        anonymous = isAnonymous
        postComments = comments
        time = when
    }
//    convenience init(object: PFObject?){
//        let user = object?["lmwUser"] as! PFUser
//        let loc  = object?["location"] as! PFGeoPoint
//        let place = object?["foodPlace"] as! String
//        let description = object?["detail"] as! String
//        let isAnonymous = object?["anonymous"] as! Bool
//        let when = object?["time"] as! String
//        let comments = object?["postComments"] as! [LWMPostComment]
//        self.init(user: user,loc: loc,place: place, when: when, description: description,isAnonymous: isAnonymous, comments: comments)
//    }
    
    class func fetchFromParse(location: PFGeoPoint,withinMiles: Double,completion:([LWMPost]?,NSError?)->()){
        let query = PFQuery(className: "LWMPost")
        query.whereKey("location", nearGeoPoint: location, withinMiles: withinMiles)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error == nil){
                var posts:[LWMPost] = []
                for object in objects!{
                    posts.append((object as? LWMPost)!)
                }
                completion(posts,nil)
            }else{
                completion(nil,error)
            }
        }
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }

}