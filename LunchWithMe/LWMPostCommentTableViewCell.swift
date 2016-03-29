//
//  LWMPostCommentTableViewCell.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/28/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit

class LWMPostCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var time: UILabel!
    
    var postComment:LWMPostComment?{
        didSet{
            if let postComment = postComment{
                if postComment.anonymous{
                    username.text = "Anonymous"
                }else{
                    username.text = postComment.lwmUser.username
                }
                content.text = postComment.content
                time.text = postComment.createdAt!.timePassedSinceCreated
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
