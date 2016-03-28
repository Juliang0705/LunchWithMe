//
//  LWMPostComment.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/24/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import Foundation
import Parse

class LWMPostComment: PFObject,PFSubclassing{
    @NSManaged var lwmUser: PFUser
    @NSManaged var anonymous: Bool
    @NSManaged var content: String
    override init(){
        super.init()
    }
    init(user:PFUser, isAnonymous: Bool, comment: String){
        super.init()
        lwmUser = user
        anonymous = isAnonymous
        content = comment
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
        return "LWMPostComment"
    }
    
//    convenience init(object: PFObject?){
//        let user = object?["lmwUser"] as! PFUser
//        let isAnonymous  = object?["anonymous"] as! Bool
//        let comment = object?["content"] as! String
//        self.init(user: user, isAnonymous: isAnonymous , comment: comment)
//    }
    
}