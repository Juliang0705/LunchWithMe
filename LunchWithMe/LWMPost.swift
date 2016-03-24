//
//  LWUPost.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/23/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import Foundation
import MapKit
import Parse

class LWMPost: NSObject{
    var lmwUser:LWMUser
    var location: PFGeoPoint
    var foodPlace: String
    var detail: String
    var placeImage: UIImage?
    
    init(user: LWMUser, loc: PFGeoPoint, place: String, description: String, placePicture: UIImage?){
        lmwUser = user
        location = loc
        foodPlace = place
        detail = description
        placeImage = placePicture
    }
    convenience init(object: PFObject?){
        let user = object?["lmwUser"] as! LWMUser
        let loc  = object?["location"] as! PFGeoPoint
        let place = object?["foodPlace"] as! String
        let description = object?["detail"] as! String
        let placePicture = object?["placeImage"] as? UIImage
        self.init(user: user,loc: loc,place: place, description: description, placePicture: placePicture)
    }
    
    class func postToParse(post post:LWMPost , completion:PFBooleanResultBlock?){
        let userObject = PFObject(className: "LWMPost")
        userObject["location"] = post.location
        userObject["foodPlace"] = post.foodPlace
        userObject["detail"] = post.detail
        userObject["lmwUser"] = post.lmwUser
        userObject["placeImage"] = post.placeImage
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

}