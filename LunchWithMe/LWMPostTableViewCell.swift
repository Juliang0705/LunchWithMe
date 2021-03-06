//
//  LWMPostTableViewCell.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/23/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit

class LWMPostTableViewCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var foodPlace: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var createdTime: UILabel!
    var post:LWMPost?{
        didSet{
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
