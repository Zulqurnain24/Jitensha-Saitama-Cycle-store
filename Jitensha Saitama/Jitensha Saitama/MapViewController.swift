//
//  MapViewController.swift
//  Jitensha Saitama
//
//  Created by Mohammad Zulqurnain on 15/07/2017.
//  Copyright © 2017 Mohammad Zulqurnain. All rights reserved.
//

import UIKit
import MapKit

/**
 # MapViewController #
 Class for handling the map based interactions
 */
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

	// MARK: - Outlets
	
	@IBOutlet weak var mapView: MKMapView!
	
	// MARK: - Search
	
	fileprivate var searchController: UISearchController!
	fileprivate var localSearchRequest: MKLocalSearchRequest!
	fileprivate var localSearch: MKLocalSearch!
	fileprivate var localSearchResponse: MKLocalSearchResponse!
	
	// MARK: - Map variables
	
	fileprivate var annotation: MKAnnotation!
	fileprivate var locationManager: CLLocationManager!
	fileprivate var isCurrentLocation: Bool = false
	
	// MARK: - Activity Indicator
	
	fileprivate var activityIndicator: UIActivityIndicatorView!

	// MARK: - UIViewController's methods
    fileprivate var  selectedAnnotationID : String!
    

	override func viewDidLoad() {
		super.viewDidLoad()

		mapView.delegate = self
		mapView.mapType = .standard
		
		activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
		activityIndicator.hidesWhenStopped = true
		self.view.addSubview(activityIndicator)
        
        if (CLLocationManager.locationServicesEnabled()) {
            if locationManager == nil {
                locationManager = CLLocationManager()
            }
            locationManager?.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            isCurrentLocation = true
            
            //call locations api and populate map
            populateAnnotationsOnMap()
            activityIndicator.startAnimating()
        }else{
            
            let alert = UIAlertController(title: "Alert", message: "Please enable location services in order to access the Jitensha Saitama Locations nearby", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: false, completion: nil)
        }

        
        
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        //activityIndicator.startAnimating()
		activityIndicator.center = self.view.center
	}
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        activityIndicator.stopAnimating()
//    }


	
    /**
     # locationManager #
     For setting visible region of the map for the user
     */
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
        print("didUpdateLocations")
        
		if !isCurrentLocation {
			return
		}
		
		isCurrentLocation = false
		
		let myLocation = locations.last

        let lat:CLLocationDegrees = myLocation!.coordinate.latitude//insert latitutde
        
        let long:CLLocationDegrees = myLocation!.coordinate.longitude//insert longitude
        
        let span = MKCoordinateSpanMake(0.3, 0.3)
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    /**
     # populateAnnotationsOnMap #
     Method for populating locationAnnotationDataArray and then plotting annotations on to the map
     */
    func populateAnnotationsOnMap(){

        //clear the annotations array
        CommonFunctionality.sharedCommonFunctionality.locationAnnotationDataArray.removeAll()
        
        DispatchQueue.global().async {[weak self] in
            
        //fetch annotations array data from json
        CommonFunctionality.sharedCommonFunctionality.doWebRequest(urlString: "http://localhost:3000/api/v2.0/places", requestType:"GET", paraDictionay: [:], failureCallback: (self?.failureCallback)!, callback:  { (responseString: NSDictionary) -> Void in
            
            print("responseString : \(responseString)")
            
            let jsonArray = responseString as NSDictionary
            
            //only pursue further if the dictionary object is not nil
            if let object:[AnyObject] = jsonArray.value(forKey: "places") as? [AnyObject] {
            
            print("I am inside!")
                
            for element in object{
                
                if let lat:Double = Double(((element["location"] as? Dictionary<String, String>)?["lat"])!), let lng:Double = Double(((element["location"] as? Dictionary<String, String>)?["lng"])!){
                    
                        print("element : \(element)")
                        
                        CommonFunctionality.sharedCommonFunctionality.locationAnnotationDataArray.append(LocationStruct(pId: element["id"] as? String, pName: element["name"] as? String, pLat:lat, pLng:lng))

                }

            }
            
            DispatchQueue.main.async {
                
                for locationStructObject in CommonFunctionality.sharedCommonFunctionality.locationAnnotationDataArray{
                    
                    let pointAnnotation = MKPointAnnotation()
                    pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: Double(locationStructObject.lat), longitude: Double(locationStructObject.lng))
                    pointAnnotation.title = locationStructObject.name
                    pointAnnotation.subtitle = locationStructObject.id
                    self?.mapView.addAnnotation(pointAnnotation)
                    print("added annotation : \(locationStructObject.name!)")
                    
                }

                self?.mapView.setNeedsDisplay()
                
                self?.activityIndicator.stopAnimating()
                
            }
                
            }
        })
        }

    }
    
    /**
    # mapView viewForAnnotation annotation:  #
    adding button to the annotation in order to segue to perform payment mode
     */
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.isEnabled = true
            pinView?.canShowCallout = true
            
            let rightButton: UIButton = UIButton(type:.detailDisclosure)

            rightButton.addTarget(rightButton , action: #selector(performSegueToPerformPaymentMethod),
                             for: .touchUpInside)
            
            pinView?.rightCalloutAccessoryView = rightButton
            
        }
        else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func performSegueToPerformPaymentMethod()
    {
     //print("accessory buton tapped!")
//    print("name : \(String(describing: view.annotation?.title!))")
//    print("id : \(String(describing: view.annotation?.subtitle!))")
//    print("location : \(String(describing: view.annotation?.coordinate))")
//    selectedAnnotationID = view.annotation?.subtitle!
    performSegue(withIdentifier: "segueToPaymentViewConroller", sender: self)
    }
    
    /**
     # mapView: didSelectAnnotationView: #
     Method for annotation selection
     */
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("accessory buton tapped!")
//        print("name : \(String(describing: view.annotation?.title!))")
//        print("id : \(String(describing: view.annotation?.subtitle!))")
//        print("location : \(String(describing: view.annotation?.coordinate))")
 
        selectedAnnotationID = view.annotation?.subtitle!
        performSegue(withIdentifier: "segueToPaymentViewConroller", sender: self)
    
        
    }
    
    /**
     # prepareForSegue #
     pass data to another view
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "segueToPaymentViewConroller") {
            
            if let cycleRentPaymentViewController:CycleRentPaymentViewController = (segue.destination as? CycleRentPaymentViewController){
            cycleRentPaymentViewController.paymentStruct =  PaymentStruct(pNumber: "", pName: "", pDate: "", pPlaceID:selectedAnnotationID!)
            }
        }
    }
    
    /**
     # mapView: viewFor annotation: #
     Handle user login and map segue
     */
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        
//        
//        let annotationIdentifier = "Identifier"
//        var annotationView: MKAnnotationView?
//        
//        guard !(annotation is MKUserLocation) else {
//            return nil
//        }
//        
//        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
//            annotationView = dequeuedAnnotationView
//            annotationView?.annotation = annotation
//        }
//        else {
//        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        
//        if let annotationView = annotationView {
//            
//            annotationView.canShowCallout = true
//            annotationView.image = UIImage(named: "annotation")
//        }
//        
//        return annotationView
//    }

}

