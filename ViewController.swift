//
//  ViewController.swift
//  Hearth
//
//  Created by Sathvik Koneru and Varun Meduri on 5/8/16.
//  Copyright © 2016 Sathvik Koneru & Varun Meduri. All rights reserved.
//
//

import UIKit
import MapKit
import CoreData
import CoreLocation

//var hotSpotDict = [String:Dictionary<String,Int>]()
var hotSpotDict = [String:[String:String]]()

var allPlaces = [Dictionary<String,String>()]
var activePlace = -1


//the purpose of this method is to control everything that happens on the one page app
//the ViewController class is essentially in charge of what appears on the user's screen
//after this code is all working properly we can make the transition to a multi-page app
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var circle:MKCircle!
    
    @IBOutlet var currLoc: UILabel!
    
    //this variable is a reference to the map interface on the storyboard
    @IBOutlet var mapView: MKMapView!
    
    
    var locationManager = CLLocationManager()
    
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    
    
    //the constructor method
    //this method is mostly used for setting up the map
    //asks new user for permission
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        
        backgroundTaskIdentifier = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({
            UIApplication.sharedApplication().endBackgroundTask(self.backgroundTaskIdentifier!)
        })
        var timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "update", userInfo: nil, repeats: true)
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        
        if (activePlace == -1){
            
            locationManager.requestAlwaysAuthorization()
            
            update()
            
        } else{
            
            mapView.showsUserLocation = true
            
            let latitude = NSString(string: allPlaces[activePlace]["lat"]!).doubleValue
            
            let longitude = NSString(string: allPlaces[activePlace]["lon"]!).doubleValue
            
            let latDelta:CLLocationDegrees = 0.01
            
            let lonDelta:CLLocationDegrees = 0.01
            
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            self.mapView.setRegion(region, animated: true)
            
            let pin = MKPointAnnotation()
            
            pin.coordinate = location
            
            pin.title = allPlaces[activePlace]["name"]
            
            self.mapView.addAnnotation(pin)
            
            
            
            
        }
        
        //let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //let context: NSManagedObjectContext = appDel.managedObjectContext
        
        //var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        
        
    }
    
    
    //updates location after timer starts n seconds
    func update() {
        
        locationManager.startUpdatingLocation()
        
    }
    
    //to ask for permission for geo data
    //if allows the app,
    //this function centers the map around the user's current location
    //can test this by changing location in debug tab
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        //print(locations)
        
        locationManager.stopUpdatingLocation()
        
        //print ("Stopped updating locations")
        
        let userLocation: CLLocation = locations[0]
        
        let latitude = userLocation.coordinate.latitude
        
        let longitude = userLocation.coordinate.longitude
        
        let latDelta:CLLocationDegrees = 0.0095
        
        let lonDelta:CLLocationDegrees = 0.0095
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.mapView.setRegion(region, animated: true)
        
        mapView.showsUserLocation = true
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {(placemarks, error) -> Void in
            
            //print(location)
            
            
            if (placemarks != nil){
                
                if placemarks!.count > 0 {
                    
                    
                    let pm = placemarks![0]
                    
                    //print(pm.locality)
                    
                    
                    var addressOut: String!
                    
                    let number: String! = pm.subThoroughfare
                    
                    let road: String! = pm.thoroughfare
                    
                    if((number != nil) && (road != nil)){
                        
                        addressOut = number! + " " + road!
                        
                        self.currLoc.text = addressOut
                        
                        if (hotSpotDict[addressOut] == nil){
                            
                            //var hotSpotDict = [String:Dictionary<String,Int>]()
                            
                            let freq = -1
                            
                            //let fields = ["lat":latitude, "long":longitude, "address":addressOut, "freq":freq]
                            var fields = [String:String]()
                            //NSString(string: allPlaces[activePlace]["lon"]!).doubleValue
                            
                            fields["lat"] = NSString(format: "%.10f", latitude) as String
                            
                            fields["long"] = NSString(format: "%.10f", longitude) as String
                            
                            fields["address"] = addressOut
                            
                            fields["freq"] = NSString(format: "%.f", freq) as String
                            
                            
                            //hotSpotDict = [addressOut: fields as! Dictionary<String, Int>]
                            hotSpotDict[addressOut] = fields
                            
                            print("Address added: " + addressOut)
                            
                        }else{
                            
                            var temp = (hotSpotDict[addressOut]!["freq"]! as NSString).doubleValue
                            
                            temp = temp - 1
                            
                            print(temp)
                            
                            hotSpotDict[addressOut]!["freq"] = NSString(format: "%.f", temp) as String
                            
                            print("Freq incremented: " + addressOut + " freq = " + hotSpotDict[addressOut]!["freq"]!)
                        }
                        
                        var n = 0
                        
                        while (n < hotspotArr.count){
                            
                            let hotLat = (hotSpotDict[hotspotArr[n]]!["lat"]! as NSString).doubleValue
                            
                            let hotLong = (hotSpotDict[hotspotArr[n]]!["long"]! as NSString).doubleValue
                            
                            let hotLoc = CLLocationCoordinate2DMake(hotLat, hotLong)
                            
                            self.circle = MKCircle(centerCoordinate: hotLoc, radius: 250)
                            
                            self.mapView.addOverlay(self.circle)
                            
                            n += 1
                            
                        }
                       
                        
                    }
                    
                }
                
            }
            else {
                print("Problem with the data received from geocoder")
                
                
            }
            
            
        })
        
        let longTouch = UILongPressGestureRecognizer(target: self, action: "action:")
        
        longTouch.minimumPressDuration = 0.25
        
        mapView.addGestureRecognizer(longTouch)
        
        
    }
    
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        
        circleRenderer.fillColor = UIColor.redColor().colorWithAlphaComponent(0.1)
        
        circleRenderer.strokeColor = UIColor.redColor()
        
        circleRenderer.lineWidth = 1
        
        return circleRenderer
    }
    
    
    //if user holds screen for over 2 seconds pin drops - gives user option to add title
    //returns a pin to the screen
    func action(gestureRecognizer: UIGestureRecognizer){
        
        if (gestureRecognizer.state == UIGestureRecognizerState.Began) {
            
            //print("Gesture Recognized")
            
            let touchPoint = gestureRecognizer.locationInView(self.mapView)
            
            let newCoordinate: CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
            
            let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                //print(location)
                
                var title = ""
                
                if (error == nil) {
                    
                    //if statement was changed
                    if let p = placemarks?[0] {
                        
                        
                        var subThoroughfare:String = ""
                        var thoroughfare:String = ""
                        
                        if p.subThoroughfare != nil {
                            
                            subThoroughfare = p.subThoroughfare!
                            
                        }
                        
                        if p.thoroughfare != nil {
                            
                            thoroughfare = p.thoroughfare!
                            
                        }
                        
                        title = "\(subThoroughfare) \(thoroughfare)"
                        
                        
                    }
                    
                }
                
                if title.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "" {
                    
                    title = "Added \(NSDate())"
                    
                }
                
                allPlaces.append(["name":title,"lat":"\(newCoordinate.latitude)","lon":"\(newCoordinate.longitude)"])
                
                //print(allPlaces)
                
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = newCoordinate
                
                annotation.title = title
                
                self.mapView.addAnnotation(annotation)
            })
            
            
            
            
        }
        
        
        
        
    }
    
    
}
