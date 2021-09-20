//
//  ViewController.swift
//  mapChallenge
//
//  Created by Sky on 19/09/2021.
//

import MapKit
import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel = MapViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupMap()
        bindingViewModel()
    }

    private func setupMap() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        if let coor = mapView.userLocation.location?.coordinate {
            mapView.setCenter(coor, animated: true)
        }
        
        // Setup current locatin button
        let mapButton = MKUserTrackingBarButtonItem(mapView: mapView)
        navigationItem.rightBarButtonItem = mapButton
        title = "Map Challenge"
    }
    
    private func bindingViewModel() {
        viewModel.onFetchLocations = { [weak self] locations in
            guard let self = self else { return }
            for loc in locations {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: loc.latitude,
                                                               longitude: loc.longitude)
                annotation.title = loc.title
                annotation.subtitle = loc.fullAddress
                self.mapView.addAnnotation(annotation)
                
                let pinLocation = CLLocation(latitude: loc.latitude, longitude: loc.longitude)
                let currentLocation = self.mapView.userLocation.location
                if let distance = currentLocation?.distance(from: pinLocation), distance.isLessThanOrEqualTo(1000) {
                    self.showAlert(title: "Map Challenge", msg: "We found a store near you\n\(loc.storeName) at \(loc.address)")
                }
            }
        }
        
        // add error handling
        self.viewModel.onErrorHandling = { [weak self] error in
            guard let self = self else { return }
            self.showAlert(title: "An error occured", msg: "Oops, something went wrong!")
        }
        
        viewModel.getLocationPermission(delegate: self)
        viewModel.fetchLocations()
    }
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = manager.location?.coordinate else { return }

        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
    }
}
