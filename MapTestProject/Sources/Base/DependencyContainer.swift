//
//  DependencyContainer.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/24/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

class DependencyContainer {
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
    func createListNavigation() -> TopNavigationController {
        return TopNavigationController(rootViewController: UIStoryboard.instantiateViewController(of: ListViewController.self))
    }
    
    func createMapNavigation() -> TopNavigationController {
        TopNavigationController(rootViewController: UIStoryboard.instantiateViewController(of: MapViewController.self))
    }
    
    func createProfileNavigation() -> TopNavigationController {
        TopNavigationController(rootViewController: UIStoryboard.instantiateViewController(of: ProfileViewController.self))
    }    
}
