//
//  MapViewController.swift
//  FreelancersApp
//
//  Created by Melina on 15.5.21.
//  Copyright © 2021 cct_edu. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var citiesAnnotations: [MKAnnotation] = []
    
    var realm = try! Realm()
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        getMyLocation()
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        getDestinationFromUser()
    }

    func getDestinationFromUser(){
               let destination = locationTextField.text
               
               if destination == "Prishtina" || destination == "prishtina"{
                   mapView.removeOverlays(mapView.overlays)
                   mapView.showAnnotations([getMyLocation(), getPrishtinaLocation()], animated: true)
                   drawPathFromMeToDestination(myLocation: getMyLocation(), destLocation: getPrishtinaLocation())
                   
               }else if destination == "Suhareka" || destination == "suhareka"{
                   mapView.removeOverlays(mapView.overlays)
                   mapView.showAnnotations([getMyLocation(), getSuharekaLocation()], animated: true)
                   drawPathFromMeToDestination(myLocation: getMyLocation(), destLocation: getSuharekaLocation())
            
               }else if destination == "Istog" || destination == "istog"{
                   mapView.removeOverlays(mapView.overlays)
                   mapView.showAnnotations([getMyLocation(), getIstoguLocation()], animated: true)
                   drawPathFromMeToDestination(myLocation: getMyLocation(), destLocation: getIstoguLocation())
               }
               else{
                   let alert = UIAlertController(title: "No Route Found", message:"Type the destination correctly", preferredStyle: .alert)

                   alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

                   self.present(alert, animated: true)
               }
           }
    
    func setZoomAndRegion(regionCenter: CLLocationCoordinate2D){
            let coordinateRegion = MKCoordinateRegion(center: regionCenter, latitudinalMeters: 150000, longitudinalMeters: 150000)
            mapView.region = coordinateRegion
    }
    
    func getMyLocation() -> MKPointAnnotation{
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
                 
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
                 
        let myLocation = MKPointAnnotation()
 
        myLocation.coordinate = CLLocationCoordinate2D(latitude:42.635231, longitude: 21.081735)
        myLocation.title = "Here I am"
        mapView.addAnnotation(myLocation)
        setZoomAndRegion(regionCenter: myLocation.coordinate)
        
        saveToRealm(location: myLocation)
        
        return myLocation
    }
    
    func saveToRealm(location: MKAnnotation){
        let locObj = LocationObject()
        locObj.title = location.title as? String
        locObj.coordinateLat = location.coordinate.latitude
        locObj.coordinateLong = location.coordinate.longitude
        try! realm.write{
            realm.add(locObj)
        }

    }
    
    func getPrishtinaLocation() -> MKPointAnnotation {
        let prishtina = MKPointAnnotation()
        prishtina.coordinate = CLLocationCoordinate2D(latitude: 42.655591, longitude: 21.159613)
               prishtina.title = "Prishtina"
               mapView.addAnnotation(prishtina)
        
        saveToRealm(location: prishtina)
        //print(realm.object(LocationObjects.self))
        return prishtina
    }
           
           
    func getSuharekaLocation() -> MKPointAnnotation{
        let suhareka = MKPointAnnotation()
            suhareka.coordinate = CLLocationCoordinate2D(latitude: 42.357406, longitude: 20.825741)
            suhareka.title = "Suhareka"
            mapView.addAnnotation(suhareka)
               
        saveToRealm(location: suhareka)
        return suhareka
        
    }
           
           
           func getIstoguLocation() -> MKPointAnnotation{
               let istog = MKPointAnnotation()
               istog.coordinate = CLLocationCoordinate2D(latitude: 42.781893, longitude: 20.485502)
               istog.title = "Istog"
               mapView.addAnnotation(istog)
               
            saveToRealm(location: istog)
            return istog
           }
           
           func drawPathFromMeToDestination(myLocation: MKPointAnnotation, destLocation: MKPointAnnotation){
               let myPlaceMark = MKPlacemark(coordinate: myLocation.coordinate)
               let destPlaceMark = MKPlacemark(coordinate: destLocation.coordinate)
               
               let myLocationMapItem = MKMapItem(placemark: myPlaceMark)
               let destLocationMapItem = MKMapItem(placemark: destPlaceMark)
               
               let directionRequest = MKDirections.Request()
               directionRequest.source = myLocationMapItem
               directionRequest.destination = destLocationMapItem
               directionRequest.requestsAlternateRoutes = true
               directionRequest.transportType = .automobile
               
               let direction = MKDirections(request: directionRequest)
               direction.calculate { (response, error) in
                   if(error == nil){
                       for route in response!.routes{
                           self.mapView.addOverlay(route.polyline, level: .aboveLabels)
                       }
                   }
               }
           }


          
       
               func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
               let renderer = MKPolylineRenderer(overlay: overlay)
               renderer.strokeColor = UIColor.blue
               renderer.lineWidth = 5.0
             
               
               return renderer
           }
    
}
