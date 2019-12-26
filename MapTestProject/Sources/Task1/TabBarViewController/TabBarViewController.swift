//
//  TabBarViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

protocol TabBarFactory {
    func createListNavigation(delegate: TabBarViewController?) -> TopNavigationController
    func createMapNavigation() -> TopNavigationController
    func createProfileNavigation() -> TopNavigationController
    func createMapViewController() -> MapViewController
}

private enum Constants {
    static let additionalSpace: CGFloat = 2.0
    static let delay = 0.0
    static let duration: TimeInterval = 0.1
    static let longDuration: TimeInterval = 0.25
    static let scale: CGFloat = 1.25
    static let standartScale: CGFloat = 1.0
    static let damping: CGFloat = 0.5
    static let velocity: CGFloat = 3.0
    static let additionalTab = 1
}

class TabBarViewController: UITabBarController {
    // MARK: - Private properties
    @IBOutlet private weak var welcomeLabel: UILabel!
    private var factory: TabBarFactory?
    
    // MARK: - Controller's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let factory = factory else {
            assertionFailure("Couldn't create factory of type 'TabBarFactory'")
            return
        }
        
        viewControllers = [
            factory.createListNavigation(delegate: self),
            factory.createMapNavigation(),
            factory.createProfileNavigation()
        ]
        
        configureTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setButtonsBackground()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let selectedTab = tabBar.items?.firstIndex(of: item),
            tabBar.subviews.count > selectedTab + Constants.additionalTab,
            let imageView = tabBar.subviews[selectedTab + Constants.additionalTab].subviews.compactMap ({ $0 as? UIImageView }).first else {
                return
        }
        
        animate(imageView)
    }
}

// MARK: - Tab bar configuration
private extension TabBarViewController {
    func setButtonsBackground() {
        guard let tabBarItems = tabBar.items, tabBarItems.count > .zero else {
            return
        }
        
        let sizeForSelection = CGSize(
            width: (tabBar.frame.width + Constants.additionalSpace) / CGFloat(tabBarItems.count),
            height: tabBar.frame.height)
        
        tabBar.selectionIndicatorImage = UIImage.makeTabBarBackgroundImage(with: sizeForSelection)
    }
    
    func configureTabBar() {
        tabBar.barTintColor = .black
        tabBar.isTranslucent = false
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white
    }
    
    func animate(_ imageView: UIImageView) {
        UIView.animate(withDuration: Constants.duration,
                       animations: {
                        imageView.transform = CGAffineTransform(
                            scaleX: Constants.scale,
                            y: Constants.scale)
        }) { _ in
            UIView.animate(withDuration: Constants.longDuration,
                           delay: Constants.delay,
                           usingSpringWithDamping: Constants.damping,
                           initialSpringVelocity: Constants.velocity,
                           options: .curveEaseInOut,
                           animations: {
                            imageView.transform = CGAffineTransform(
                                scaleX: Constants.standartScale,
                                y: Constants.standartScale)
            }, completion: nil)
        }
    }
}

// MARK: - Injectable
extension TabBarViewController: Injectable {
    struct Dependencies {
        let factory: TabBarFactory
    }
    
    func inject(dependencies: Dependencies) {
        factory = dependencies.factory
    }
}

// MARK: - DataTransferableProtocol
extension TabBarViewController: DataTransferableProtocol {
    func showCityOnMap(for city: CityModel) {
        guard let topController = viewControllers?[safe: 1] else { return }
        let controller = topController.children.first as? MapViewController
        controller?.viewDidLoad()
        controller?.showSelectedCityOnMap(city)
        selectedIndex = 1
    }
}
