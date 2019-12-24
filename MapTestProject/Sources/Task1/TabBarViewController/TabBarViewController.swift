//
//  TabBarViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    @IBOutlet private weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let listNavigation = TopNavigationController(rootViewController: UIStoryboard.instantiateViewController(of: ListViewController.self))
        let mapNavigation = TopNavigationController(rootViewController: UIStoryboard.instantiateViewController(of: MapViewController.self))
        let profileNavigation = TopNavigationController(rootViewController: UIStoryboard.instantiateViewController(of: ProfileViewController.self))
        
        viewControllers = [
            listNavigation,
            mapNavigation,
            profileNavigation
        ]
        
        configureTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setButtonsBackground()
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let selectedTab = tabBar.items?.firstIndex(of: item),
            tabBar.subviews.count > selectedTab + 1,
            let imageView = tabBar.subviews[selectedTab + 1].subviews.compactMap ({ $0 as? UIImageView }).first else {
            return
        }
        
        animate(imageView)
    }
}

// MARK: - Tab bar configuration
private extension TabBarViewController {
    func setButtonsBackground() {
        guard let tabBarItems = tabBar.items, tabBarItems.count > 0 else {
            return
        }

        let sizeForSelection = CGSize(
            width: (tabBar.frame.width + 2.0) / CGFloat(tabBarItems.count),
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
        UIView.animate(withDuration: 0.1, animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3.0, options: .curveEaseInOut, animations: {
                imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }
}
