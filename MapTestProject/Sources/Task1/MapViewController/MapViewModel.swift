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

class MapViewModel: MapViewModelDelegate {
    private var cityService: CityServiceHandler?
    var cityDestinations = [CityModel]()
    private var arrayOfPoints = ["Point1", "Point2", "Point3", "Point4", "Point5"]
    
    func getCitiesInfo() {
           cityService?.fetchData(points: arrayOfPoints) { [weak self] in
               self?.response(data: $0)
           }
       }
    
    private func response(data: [CityModel]?) {
           guard let data = data else { return }
           cityDestinations = data
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
