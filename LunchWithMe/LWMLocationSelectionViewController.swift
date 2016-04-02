//
//  LWMLocationSelectionViewController.swift
//  LunchWithMe
//
//  Created by Juliang Li on 4/2/16.
//  Copyright © 2016 Juliang. All rights reserved.
//

import UIKit
import Mapbox

class LWMLocationSelectionViewController: UIViewController, MGLMapViewDelegate {

    @IBOutlet weak var mapView: MGLMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initGUI()
        centerUserPostion() // check if location data is available now
        monitorLocation()
    }
    
    func initGUI(){
        mapView.delegate = self
        mapView.showsUserLocation = true
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "userDidPress:")
        mapView.addGestureRecognizer(longPressRecognizer)
        
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
                zoomLevel: 14, animated: false)
        }
    }

    func userDidPress(recognizer: UIGestureRecognizer){
        if recognizer.state == .Began{
            //get rid of old annotation
            if let annotations = mapView.annotations{
                mapView.removeAnnotations(annotations)
                mapView.showsUserLocation = true
            }
            // get the location info from the map
            let point = recognizer.locationInView(mapView)
            let coordinate = mapView.convertPoint(point, toCoordinateFromView: mapView)
            //make annotation
            let annotation = MGLPointAnnotation()
            annotation.coordinate = coordinate
            //get street details
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude), completionHandler: { (placeMarks, error) -> Void in
                if error == nil{
                    if (placeMarks!.count > 0){
                        let placeMark = placeMarks![0]
                        var address = ""
                        var subAddress = ""
                        if placeMark.subThoroughfare != nil {
                            address = placeMark.subThoroughfare! + " "
                        }
                        if placeMark.thoroughfare != nil {
                            address = address + placeMark.thoroughfare!
                        }
                        if placeMark.locality != nil {
                            subAddress = placeMark.locality! + ", "
                        }
                        if placeMark.administrativeArea != nil {
                            subAddress = subAddress + placeMark.administrativeArea! + " "
                        }
                        if placeMark.postalCode != nil {
                            subAddress = subAddress + placeMark.postalCode! + " "
                        }
                        annotation.title = address
                        annotation.subtitle = subAddress
                    }
                }else{
                    annotation.title = "You Picked Here"
                }
               self.mapView.addAnnotation(annotation)
               self.mapView.selectAnnotation(annotation, animated: true)
            })
        }
    }
    
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(mapView: MGLMapView, rightCalloutAccessoryViewForAnnotation annotation: MGLAnnotation) -> UIView? {
        let button = UIButton(type: .ContactAdd)
        return button
    }
    
    func mapView(mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
        self.performSegueWithIdentifier("LWMPostCompose", sender: annotation)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let annotation = sender as? MGLAnnotation{
            if let postComposeViewController = segue.destinationViewController as? LWMPostComposeViewController{
                let coordinate = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
                postComposeViewController.selectedLocation = coordinate
            }
        }
    }

}
