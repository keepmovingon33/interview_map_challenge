//
//  MapViewModel.swift
//  mapChallenge
//
//  Created by Sky on 19/09/2021.
//

import CoreLocation
import UIKit

struct MapViewModel {
    weak var service: LocationServiceProtocol?
    var onErrorHandling : ((ErrorResult?) -> Void)?
    var onFetchLocations : (([Location]) -> Void)?
    
    let locationManager = CLLocationManager()
    
    init(service: LocationServiceProtocol = FileDataService.shared) {
        self.service = service
    }
    
    func fetchLocations() {
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        
        service.fetchLocations { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let locations):
                    self.onFetchLocations?(locations)
                case .failure(let error):
                    self.onErrorHandling?(error)
                }
            }
        }
    }
    
    func getLocationPermission(delegate: CLLocationManagerDelegate) {
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = delegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
}
