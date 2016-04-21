//
//  ViewController.swift
//  Compass Demo
//
//  Created by Samuel Lichlyter on 4/21/16.
//  Copyright © 2016 Samuel Lichlyter. All rights reserved.
//

import UIKit
import CoreLocation

// Tell the compiler this is a location manager delegate
class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var magneticHeadingLabel: UILabel!
    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        // Check if we're allowed to use location services, if not display an alert
        if (CLLocationManager.authorizationStatus() == .Denied || CLLocationManager.authorizationStatus() == .Restricted) {
            let cannotUseLocationServicesAlert = UIAlertController(title: "Oops!", message: "Please enable location services to use this awesome app!", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "I'm right on it!", style: .Default, handler: nil)
            cannotUseLocationServicesAlert.addAction(cancelAction)
            presentViewController(cannotUseLocationServicesAlert, animated: true, completion: nil)
            return
        }
        
        // Declare your location manager and set its delegate
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        // Check if auth status was determined, if not request to use location only when using the app
        if (CLLocationManager.authorizationStatus() == .NotDetermined) {
            locationManager.requestWhenInUseAuthorization()
        }
        
        // Tell the app to use heading and to start updating it
        CLLocationManager.headingAvailable()
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        headingLabel.text = String(format: "%.0f", newHeading.trueHeading)
        magneticHeadingLabel.text = String(format: "%.0f", newHeading.magneticHeading)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

