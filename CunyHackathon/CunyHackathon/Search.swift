//
//  Home.swift
//  CunyHackathon
//
//  Created by Keith Cornish on 4/28/18.
//  Copyright © 2018 Keith Cornish. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CSV

class Search: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapKitView: MKMapView!
    @IBOutlet weak var segmentControlBlurView: UIVisualEffectView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    private let locationManager = CLLocationManager()
    var  data:[[String:String]] = []
    var  columnTitles:[String] = []
    private let restarauntImageArray: [UIImage] = [#imageLiteral(resourceName: "Baruch-college"),
                                                   #imageLiteral(resourceName: "Maialino"),
                                                   #imageLiteral(resourceName: "Cosme"),
                                                   #imageLiteral(resourceName: "Hillstone-sign"),
                                                   #imageLiteral(resourceName: "ABC-kitchen")]
    private let titleArray: [String] = ["Baruch College",
                                        "Maialino",
                                        "Cosme",
                                        "Hillstone",
                                        "ABC Kitchen"]
    private let subtitleArray: [String] = ["Institution",
                                           "Resturaunt",
                                           "Resturaunt",
                                           "Resturaunt",
                                           "Resturaunt"]
    private let latitudeArray: [CLLocationDegrees] = [40.740199,
                                                      40.738553,
                                                      40.739616,
                                                      40.743042,
                                                      40.737742]
    private let longitudeArray: [CLLocationDegrees] = [-73.983374,
                                                       -73.985895,
                                                       -73.988357,
                                                       -73.984817,
                                                       -73.989615]
    private var didSelectFood: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()){
            
            // locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
            segmentControl.addTarget(self, action: #selector(Search.segmentTapped(_:)), for: .valueChanged)
            
        }
        
         for i in (0..<(latitudeArray.count)){
            
            let latitude = latitudeArray[i]
            let longitude = longitudeArray[i]
            let location = CLLocationCoordinate2DMake(latitude, longitude)
            let title = titleArray[i]
            let type = subtitleArray[i]
            let foodAnnotation = FoodAnnotation(title: title, type: type, tag: i, coordinate: location)
            mapKitView.addAnnotation(foodAnnotation)
        
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Search"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.title = "Search"
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        manager.stopUpdatingLocation()
        
        let userLocation: CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        mapKitView.setRegion(region, animated: true)
        
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? FoodAnnotation else { return nil }

        let identifier = "food"
        
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            
            dequeuedView.annotation = annotation
            view = dequeuedView
            
        }
        else {
            
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)

            if(didSelectFood == true){
                
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                let infoBtn = UIButton(type: .detailDisclosure)
                view.rightCalloutAccessoryView = infoBtn
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                imageView.clipsToBounds = true
                imageView.contentMode = .scaleAspectFit
                imageView.image = restarauntImageArray[annotation.tag]
                view.leftCalloutAccessoryView = imageView
                
            }
            
        }
        
        return view
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            
            performSegue(withIdentifier: "showPickUp", sender: nil)
            
        }
        
    }
    
    private func getCSVFile(filePath: String){
        
        // Send user data to server side
        var databaseReq = URLRequest(url: URL(string: filePath)!)
        databaseReq.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: databaseReq, completionHandler: {
            data, response, error in
            
            if error != nil {
                
                print("ERROR")
                
                return
            }
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("getCSVFile: = \(responseString!)")
            
            do{
                
                if let array = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSMutableArray{
                    
                    DispatchQueue.main.async {
                        self.mapKitView.delegate = self 
                        for i in (0..<(array.count)){
                            
                            let row = array[i] as! [String:AnyObject]
                            if((row["latitude"] as? String) != nil){
                                
                                if((row["longitude"] as? String) != nil){
                                    
                                    let latitude = Double((row["latitude"] as? String)!)!
                                    let longitude = Double((row["longitude"] as? String)!)!
                                    let location = CLLocationCoordinate2DMake(latitude, longitude)
                                    let title = (row["homebase_office"] as? String)!
                                    let type = (row["borough"] as? String)!
                                    let foodAnnotation = FoodAnnotation(title: title, type: type, tag: i, coordinate: location)
                                    self.mapKitView.addAnnotation(foodAnnotation)
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            catch{
                
                print("Error: \(error)")
                
            }
            
        })
        
        task.resume()
        
    }
    
    @objc func segmentTapped(_ sender: UISegmentedControl){
        
        let allAnnotations = self.mapKitView.annotations
        self.mapKitView.removeAnnotations(allAnnotations)
        self.mapKitView.delegate = nil
        
        switch sender.selectedSegmentIndex{
            
        case 0:
            
            didSelectFood = true
            
            for i in (0..<(latitudeArray.count)){
                
                let latitude = latitudeArray[i]
                let longitude = longitudeArray[i]
                let location = CLLocationCoordinate2DMake(latitude, longitude)
                let title = titleArray[i]
                let type = subtitleArray[i]
                let foodAnnotation = FoodAnnotation(title: title, type: type, tag: i, coordinate: location)
                mapKitView.addAnnotation(foodAnnotation)
                
            }
            
        case 1:
            
            didSelectFood = false
            
            getCSVFile(filePath: "https://data.cityofnewyork.us/resource/5ud2-iqje.json")
            
        default:
            break
            
        }
        
    }
    
    @IBAction func userLocationBtnTapped(_ sender: Any) {
        
        locationManager.startUpdatingLocation()

        if(CLLocationManager.locationServicesEnabled()){
            
            if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse){
                
                locationManager.startUpdatingLocation()

            }
            
        }
        
    }
    
}
