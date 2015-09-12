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

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var postItemButton: UIButton!
    let locationManager = CLLocationManager()
    var foundLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.postItemButton.layer.shadowColor = UIColor.grayColor().CGColor
        self.postItemButton.layer.shadowOffset = CGSizeMake(0, 1.0)
        self.postItemButton.layer.shadowOpacity = 1.0
        self.postItemButton.layer.shadowRadius = 8.0
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
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
    
}

