//
//  DependencyContainer.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/24/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

final class DependencyContainer {
    func createNavigationController() -> BaseNavigationController {
        let controller = UIStoryboard.instantiateViewController(of: RegistrationViewController.self)
        let viewModel = RegistrationViewModel(factory: self)
        viewModel.view = controller
        let dependencies = RegistrationViewController.Dependencies(viewModel: viewModel)
        controller.inject(dependencies: dependencies)
        return BaseNavigationController(rootViewController: controller)
    }
    
    func createTabBarController() -> TabBarViewController {
        return createTabBar()
    }
}

// MARK: - RegistrationFactory
extension DependencyContainer: RegistrationFactory {
    func createTabBar() -> TabBarViewController {
        let controller = UIStoryboard.instantiateViewController(of: TabBarViewController.self)
        let dependencies = TabBarViewController.Dependencies(factory: self)
        controller.inject(dependencies: dependencies)
        return controller
    }
}

// MARK: - TabBarFactory
extension DependencyContainer: TabBarFactory {
    func createListNavigation(delegate: TabBarViewController?) -> TopNavigationController {
        let controller = UIStoryboard.instantiateViewController(of: ListViewController.self)
        let viewModel = ListViewModel()
        let viewModelDependencies = ListViewModel.Dependencies(cityService: CityService())
        viewModel.inject(dependencies: viewModelDependencies)
        viewModel.view = controller
        let dependencies = ListViewController.Dependencies(viewModel: viewModel)
        controller.inject(dependencies: dependencies)
        controller.mapDelegate = delegate
        return TopNavigationController(rootViewController: controller)
    }
    
    func createMapNavigation() -> TopNavigationController {
        let controller = UIStoryboard.instantiateViewController(of: MapViewController.self)
        let viewModel = MapViewModel()
        let viewModelDependencies = MapViewModel.Dependencies(cityService: CityService())
        viewModel.inject(dependencies: viewModelDependencies)
        let dependencies = MapViewController.Dependencies(viewModel: viewModel)
        controller.inject(dependencies: dependencies)
        return TopNavigationController(rootViewController: controller)
    }
    
    func createProfileNavigation() -> TopNavigationController {
        TopNavigationController(rootViewController: UIStoryboard.instantiateViewController(of: ProfileViewController.self))
    }
    
    func createMapViewController() -> MapViewController {
        let controller = UIStoryboard.instantiateViewController(of: MapViewController.self)
        let viewModel = MapViewModel()
        let viewModelDependencies = MapViewModel.Dependencies(cityService: CityService())
        viewModel.inject(dependencies: viewModelDependencies)
        let dependencies = MapViewController.Dependencies(viewModel: viewModel)
        controller.inject(dependencies: dependencies)
        return controller
    }
}
