//
//  ViewController.swift
//  Trayl
//
//  Created by Aniruddha Nadkarni on 9/11/15.
//  Copyright © 2015 Aniruddha Nadkarni. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var postItemButton: UIButton!
    let locationManager = CLLocationManager()
    var foundLocation = false
    var postMode = false
    var confirmPresent = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.postItemButton.layer.shadowColor = UIColor.grayColor().CGColor
        self.postItemButton.layer.shadowOffset = CGSizeMake(0, 1.0)
        self.postItemButton.layer.shadowOpacity = 1.0
        self.postItemButton.layer.shadowRadius = 8.0
        self.postItemButton.layer.cornerRadius = 5.0
        
        self.confirmButton.layer.shadowColor = UIColor.grayColor().CGColor
        self.confirmButton.layer.shadowOffset = CGSizeMake(0, 1.0)
        self.confirmButton.layer.shadowOpacity = 1.0
        self.confirmButton.layer.shadowRadius = 8.0
        self.confirmButton.layer.cornerRadius = 5.0
        
        self.cancelButton.layer.shadowColor = UIColor.grayColor().CGColor
        self.cancelButton.layer.shadowOffset = CGSizeMake(0, 1.0)
        self.cancelButton.layer.shadowOpacity = 1.0
        self.cancelButton.layer.shadowRadius = 8.0
        self.cancelButton.layer.cornerRadius = 5.0
        
        self.confirmButton.transform = CGAffineTransformMakeTranslation(0, 150)
        self.cancelButton.transform = CGAffineTransformMakeTranslation(0, 120)
        
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        let tapCheck = UITapGestureRecognizer(target: self, action: "addPin:")
        tapCheck.numberOfTapsRequired = 1
        tapCheck.numberOfTouchesRequired = 1
        mapView.addGestureRecognizer(tapCheck)
        
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            // TODO: If user does not authorize
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !foundLocation {
            let location = locations.first
            mapView.setCamera(MKMapCamera(lookingAtCenterCoordinate: (location?.coordinate)!, fromEyeCoordinate: (location?.coordinate)!, eyeAltitude: 1000.0), animated: false)
            foundLocation = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
    @IBAction func postItem(sender: AnyObject) {
        postMode = true
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            self.cancelButton.transform = CGAffineTransformMakeTranslation(0, 0)
            self.postItemButton.alpha = 0.0
            self.postItemButton.transform = CGAffineTransformMakeTranslation(0, 120)
            }) { (bool) -> Void in
        }
        
    }
    
    
    @IBAction func cancelPosting(sender: AnyObject) {
        postMode = false
        if (confirmPresent) {
            confirmPresent = false
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                self.cancelButton.transform = CGAffineTransformMakeTranslation(0, 120)
                self.confirmButton.transform = CGAffineTransformMakeTranslation(0, 150)
                self.postItemButton.alpha = 1.0
                self.postItemButton.transform = CGAffineTransformMakeTranslation(0, 0)
                }) { (bool) -> Void in
            }
        } else {
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                self.cancelButton.transform = CGAffineTransformMakeTranslation(0, 120)
                self.postItemButton.alpha = 1.0
                self.postItemButton.transform = CGAffineTransformMakeTranslation(0, 0)
                }) { (bool) -> Void in
            }
        }
        
        
    }

    @IBAction func addPin(recognizer: UITapGestureRecognizer) {
        if (postMode) {
            if !confirmPresent {
                confirmPresent = true
                UIView.animateWithDuration(0.325, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                    self.confirmButton.transform = CGAffineTransformMakeTranslation(0, 0)
                    }) { (bool) -> Void in
                }
            }
            let point = recognizer.locationInView(self.mapView)
            let location = mapView.convertPoint(point, toCoordinateFromView: self.view)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            self.mapView.addAnnotation(annotation)
        }
        
    }
    
    
}

