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
        LWMNotification.requestLocationUpdate()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        showPostsOnMap()
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
        if let annotations = mapView.annotations{
            mapView.removeAnnotations(annotations)
        }
        if let posts = LWMSharedposts{
            var index = 0;
            for post in posts{
                let point = MGLPointAnnotation()
                point.coordinate = CLLocationCoordinate2D(latitude: post.location.latitude, longitude: post.location.longitude)
                if post.anonymous{
                    point.title = "Anonymous"
                }else{
                    point.title = post.lwmUser.username!
                }
                point.subtitle = post.foodPlace
                index = index + 1
                mapView.addAnnotation(point)
                mapView.selectAnnotation(point, animated: true)
            }
        }else{
            print("Can't show post on map")
        }
    }
    
    func mapView(mapView: MGLMapView, rightCalloutAccessoryViewForAnnotation annotation: MGLAnnotation) -> UIView? {
        let button = UIButton(type: .InfoLight)
        return button
    }
    func mapView(mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = annotation as? MGLPointAnnotation{
            if let allAnnotations = mapView.annotations{
                let index = allAnnotations.indexOf({ $0 === annotation})
                self.performSegueWithIdentifier("LWMPostDetail", sender: LWMSharedposts![index!])
            }
        }
        
       // self.performSegueWithIdentifier("LWMPostDetail", sender: annotation)
    }
    
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let postDetailViewController = segue.destinationViewController as? LWMPostDetailViewController{
            if let post = sender as? LWMPost{
                postDetailViewController.post = post
            }
        }
    }

}
