//
//  MapViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit
import GoogleMaps

final class MapViewController: UIViewController {
    // MARK: - Private properties
    private var viewModel: MapViewModelDelegate?
    private var mapView: GMSMapView?
    private var currentDestination: CityModel?
    private var currentCamera: GMSCameraPosition?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tabBarItem = TabBarItem.map.makeTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = TabBarItem.map.makeTabBarItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        viewModel?.getCitiesInfo()
        mapView?.isMyLocationEnabled = true
        showDefaultCity()
        LocationManager.shared.delegate = self
        LocationManager.shared.startUpdatingLocation()
    }
    
    private func configureNavigation() {
        navigationItem.title = "Map screen"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(switchToNextPoint))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(goToCurrentPosition))
    }
    
    private func showDefaultCity() {
        let camera = GMSCameraPosition.camera(withLatitude: 50.45466, longitude: 30.5238, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView

        createMarker(latitude: 50.45466, longitude: 30.5238, name: "Kiev")
    }
    
    @objc private func goToCurrentPosition() {
        currentDestination = nil
        LocationManager.shared.startUpdatingLocation()
        guard let home = currentCamera else { return }
        mapView?.animate(to: home)
    }
    
    @objc private func switchToNextPoint() {
        if currentDestination == nil {
            currentDestination = viewModel?.cityDestinations.first
        } else {
            guard let destination = currentDestination,
                let index = viewModel?.cityDestinations.firstIndex(of: destination),
                let cities = viewModel?.cityDestinations else {
                    return
            }
            
            if index < (cities.count - 1) {
                let currentIndex = viewModel?.cityDestinations[index + 1]
                currentDestination = currentIndex
            }
        }
        
        createAnimation()
    }
    
    func showSelectedCityOnMap(_ city: CityModel) {
        LocationManager.shared.stopUpdatingLocation()
        guard let latitude = city.latitude, let longitude = city.longitude else { return }
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        createMarker(latitude: latitude, longitude: longitude, name: city.name)
    }
    
    private func createAnimation() {
        CATransaction.begin()
        CATransaction.setValue(2.0, forKey: kCATransactionAnimationDuration)
        
        guard let latitude = currentDestination?.latitude, let longitude = currentDestination?.longitude else { return }
        mapView?.animate(to: GMSCameraPosition.camera(
            withLatitude: latitude,
            longitude: longitude,
            zoom: 10))
        
        CATransaction.commit()
        createMarker(latitude: latitude, longitude: longitude, name: currentDestination?.name)
    }
    
    private func createMarker(latitude: CLLocationDegrees, longitude: CLLocationDegrees, name: String?) {
        let markerPosition = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker = GMSMarker(position: markerPosition)
        marker.title = name
        marker.icon = UIImage(named: "mapIcon")
        marker.map = mapView
    }
}

// MARK: - Injectable
extension MapViewController: Injectable {
    struct Dependencies {
        let viewModel: MapViewModelDelegate
    }
    
    func inject(dependencies: Dependencies) {
        viewModel = dependencies.viewModel
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location = locations.last

        guard let latitude = location?.coordinate.latitude, let longitude = location?.coordinate.longitude else { return }
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 10.0)
        currentCamera = camera
        mapView?.animate(to: camera)
        
        let markerPosition = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker = GMSMarker(position: markerPosition)
        marker.title = "Current Location"
        marker.icon = UIImage(named: "mapIcon")
        marker.map = mapView

        LocationManager.shared.stopUpdatingLocation()
    }
}
