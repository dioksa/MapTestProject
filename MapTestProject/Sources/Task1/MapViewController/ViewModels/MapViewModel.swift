//
//  MapViewModel.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/25/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import Foundation

protocol MapViewModelDelegate {
    var cityDestinations: [CityModel] { get }
    func getCitiesInfo()
}

final class MapViewModel: MapViewModelDelegate {
    // MARK: - Private properties
    private var cityService: CityServiceHandler?
    private var arrayOfPoints = ["Point1", "Point2", "Point3", "Point4", "Point5"]
    
    // MARK: - MapViewModelDelegate
    var cityDestinations = [CityModel]()
    
    func getCitiesInfo() {
        cityService?.fetchData(points: arrayOfPoints) { [weak self] in
            self?.response(data: $0)
        }
    }
    
    // MARK: - Private methods
    private func response(data: [CityModel]?) {
        guard let data = data else { return }
        
        let filteredCities = data.filter { $0.latitude != nil && $0.longitude != nil }
        cityDestinations = filteredCities
    }
}

// MARK: - Injectable
extension MapViewModel: Injectable {
    struct Dependencies {
        let cityService: CityServiceHandler
    }
    
    func inject(dependencies: Dependencies) {
        cityService = dependencies.cityService
    }
}
