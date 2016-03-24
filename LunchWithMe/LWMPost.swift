//
//  LWUPost.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/23/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import Foundation
import Parse

class LWMPost: NSObject{
    var lmwUser:LWMUser
    var location: PFGeoPoint
    var foodPlace: String
    var detail: String
    var anonymous: Bool
    var postComments: [LWMPostComment]
    var time: String
    
    init(user: LWMUser, loc: PFGeoPoint, place: String,when: String, description: String,isAnonymous: Bool,comments: [LWMPostComment]){
        lmwUser = user
        location = loc
        foodPlace = place
        detail = description
        anonymous = isAnonymous
        postComments = comments
        time = when
    }
    convenience init(object: PFObject?){
        let user = object?["lmwUser"] as! LWMUser
        let loc  = object?["location"] as! PFGeoPoint
        let place = object?["foodPlace"] as! String
        let description = object?["detail"] as! String
        let isAnonymous = object?["anonymous"] as! Bool
        let when = object?["time"] as! String
        let comments = object?["postComments"] as! [LWMPostComment]
        self.init(user: user,loc: loc,place: place, when: when, description: description,isAnonymous: isAnonymous, comments: comments)
    }
    
    class func postToParse(post post:LWMPost , completion:PFBooleanResultBlock?){
        let userObject = PFObject(className: "LWMPost")
        userObject["location"] = post.location
        userObject["foodPlace"] = post.foodPlace
        userObject["detail"] = post.detail
        userObject["lmwUser"] = post.lmwUser
        userObject["anonymous"] = post.anonymous
        userObject["postComments"] = post.postComments
        userObject["time"] = post.time
        userObject.saveInBackgroundWithBlock(completion)
    }
    
    class func fetchFromParse(location: PFGeoPoint,withinMiles: Double,completion:([LWMPost]?,NSError?)->()){
        let query = PFQuery(className: "LWMPost")
        query.whereKey("location", nearGeoPoint: location, withinMiles: withinMiles)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error == nil){
                var posts:[LWMPost] = []
                for object in objects!{
                    posts.append(LWMPost(object: object))
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