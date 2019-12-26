//
//  ListViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol ListViewFactory {
    func openMapView()
}

protocol DataTransferableProtocol: AnyObject {
    func showCityOnMap(for city: CityModel)
}
    
    
final class ListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!

    private var viewModel: ListViewModelDelegate?
    
    weak var mapDelegate: DataTransferableProtocol?
        
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tabBarItem = TabBarItem.list.makeTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = TabBarItem.list.makeTabBarItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(longPressGestureRecognizer:)))
        tableView.addGestureRecognizer(longPressRecognizer)
        navigationItem.title = "List screen"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CityPointCell", bundle: nil), forCellReuseIdentifier: "CityPointCell")
        viewModel?.getCitiesInfo()
    }
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        let longPress = longPressGestureRecognizer as UILongPressGestureRecognizer

        switch longPress.state {
        case .began:
            let locationInView = longPress.location(in: tableView)
            guard let indexPath = tableView.indexPathForRow(at: locationInView) else { return }
            viewModel?.deleteRow(with: indexPath)
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.sortedCitiesArray().count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityPointCell") as? CityPointCell, let cities = viewModel?.sortedCitiesArray() else { return UITableViewCell() }
        
        cell.configureCell(with: (cities[indexPath.row]))
        spinner.stopAnimating()
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let city = viewModel?.sortedCitiesArray()[indexPath.row] else { return }
        
        guard city.latitude != nil, city.longitude != nil else {
           addAlertMessage(alertTitle: "There are no available points to show on map")
            return
        }
        
        mapDelegate?.showCityOnMap(for: city)
    }
}

// MARK: - Injectable
extension ListViewController: Injectable {
    struct Dependencies {
        let viewModel: ListViewModelDelegate
    }
    
    func inject(dependencies: Dependencies) {
        viewModel = dependencies.viewModel
    }
}

// MARK: - ListViewDataDisplaying
extension ListViewController: ListViewDataDisplaying {
    func deleteCell(with indexPath: IndexPath?) {
        tableView.deleteRows(at: [indexPath!], with: .fade)
        viewModel?.getCitiesInfo()
        tableView.reloadData()
    }
    

    func updateTableViewCells() {
        tableView.reloadData()
    }
}
