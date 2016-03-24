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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
