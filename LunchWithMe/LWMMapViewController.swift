//
//  LWMMapViewController.swift
//  LunchWithMe
//
//  Created by Juliang Li on 3/30/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import Mapbox

class LWMMapViewController: UIViewController, MGLMapViewDelegate {

    @IBOutlet weak var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initGUI(){
        mapView.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
