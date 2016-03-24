//
//  LWMUser.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/21/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import Foundation
import Parse

var currentUser: LWMUser?

class LWMUser: NSObject {
    var username: String
    var anonymous: Bool
    var parseUser: PFUser
    init(user: PFUser, isAnonymous: Bool){
        parseUser = user
        anonymous = isAnonymous
        username = user.username!
    }
    convenience init(object: PFObject?){
        let user = object?["parseUser"] as! PFUser
        let isAnonymous = object?["anonymous"] as! Bool
        self.init(user: user,isAnonymous: isAnonymous)
    }
    class func postToParse(user user:LWMUser , completion:PFBooleanResultBlock?){
        let userObject = PFObject(className: "LWMUser")
        userObject["username"] = user.username
        userObject["anonymous"] = user.anonymous
        userObject["parseUser"] = user.parseUser
        userObject.saveInBackgroundWithBlock(completion)
    }
    class func fetchFromParse(name name:String,completion:(LWMUser?,NSError?)->()){
        let query = PFQuery(className: "LWMUser")
        query.whereKey("username", equalTo: name)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error == nil){
                if (objects?.count == 1){
                    let object = objects?.first
                    completion(LWMUser(object:object),nil)
                }else{
                    completion(nil,NSError(domain: "Fatal Error", code: 1, userInfo: nil))
                }
            }else{
                completion(nil,error)
            }
        }
    }
}

