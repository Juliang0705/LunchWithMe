//
//  LWMPostComment.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/24/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import Foundation
import Parse

class LWMPostComment: NSObject{
    var lwmUser: LWMUser
    var anonymous: Bool
    var content: String
    init(user:LWMUser, isAnonymous: Bool, comment: String){
        lwmUser = user
        anonymous = isAnonymous
        content = comment
    }
    convenience init(object: PFObject?){
        let user = object?["lmwUser"] as! LWMUser
        let isAnonymous  = object?["anonymous"] as! Bool
        let comment = object?["content"] as! String
        self.init(user: user, isAnonymous: isAnonymous , comment: comment)
    }
    
}