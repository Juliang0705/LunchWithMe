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
        initGUI()
        centerUserPostion() // check if location data is available now
        monitorLocation()
    }
    
    func initGUI(){
        mapView.delegate = self
        showPostsOnMap()
    }
    
    func monitorLocation(){
        NSNotificationCenter.defaultCenter().addObserverForName(LWMNotification.LocationDidUpdate, object: nil, queue: NSOperationQueue.mainQueue()) {(notification) -> Void in
            self.centerUserPostion()
        }
    }
    
    func centerUserPostion(){
        if let location = LWMCurrentLocation{
            mapView.setCenterCoordinate(CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude),
                zoomLevel: 12, animated: false)
        }
    }
    
    func showPostsOnMap(){
        if let posts = LWMSharedposts{
            for post in posts{
                let point = MGLPointAnnotation()
                point.coordinate = CLLocationCoordinate2D(latitude: post.location.latitude, longitude: post.location.longitude)
                if post.anonymous{
                    point.title = "Anonymous"
                }else{
                    point.title = post.lwmUser.username!
                }
                point.subtitle = post.foodPlace
                mapView.addAnnotation(point)
            }
        }
    }
    
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
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
