//
//  warningView.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/21/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import Foundation
import UIKit

func showWarningViewWithMessage(message: String, title: String?,parentViewController: UIViewController){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
    parentViewController.presentViewController(alert,animated: true,completion: nil)
}
