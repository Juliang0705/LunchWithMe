//
//  LWMPostCommentView.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/28/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit

class LWMPostDetailView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    // to include child even if it is outside the bounds
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if(!self.clipsToBounds && !self.hidden && self.alpha > 0.0){
            let subviews = self.subviews.reverse()
            for member in subviews {
                let subPoint = member.convertPoint(point, fromView: self)
                if let result:UIView = member.hitTest(subPoint, withEvent:event) {
                    return result;
                }
            }
        }
        return nil
    }
}
