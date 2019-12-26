//
//  ListViewModel.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/24/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import Foundation

protocol ListViewModelDelegate {
    func sortedCitiesArray() -> [CityModel]
    func getCitiesInfo()
    func deleteRow(with path: IndexPath)
}

protocol ListViewDataDisplaying: AnyObject {
    func updateTableViewCells()
    func deleteCell(with indexPath: IndexPath?)
}

final class ListViewModel: ListViewModelDelegate {
    // MARK: - Private properties
    private var cityService: CityServiceHandler?
    private var citiesToShow = [CityModel]()
    private var arrayOfPoints = ["Point1", "Point2", "Point3", "Point4", "Point5"]
    
    // MARK: - Variables
    weak var view: ListViewDataDisplaying?

    // MARK: - Methods
    func getCitiesInfo() {
        cityService?.fetchData(points: arrayOfPoints) { [weak self] in
            self?.response(data: $0)
        }
    }
    
    func sortedCitiesArray() -> [CityModel] {
        return citiesToShow.sorted(by: { $0.name < $1.name })
    }
    
    func deleteRow(with indexPath: IndexPath) {
        FirebaseManager.shared.removeCity(point: sortedCitiesArray()[indexPath.row].identifier)
        citiesToShow.removeLast()
        view?.deleteCell(with: indexPath)
    }
    
    // MARK: - Private methods
    private func response(data: [CityModel]?) {
        guard let data = data else { return }
        citiesToShow = data
        view?.updateTableViewCells()
    }
}

// MARK: - Injectable
extension ListViewModel: Injectable {
    struct Dependencies {
        let cityService: CityServiceHandler
    }
    
    func inject(dependencies: Dependencies) {
        cityService = dependencies.cityService
    }
}
