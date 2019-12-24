//
//  TabBarItem.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

enum TabBarItem {
    case list
    case map
    case profile
}

extension TabBarItem {
    func makeTabBarItem() -> UITabBarItem {
        let items: (String, UIImage, UIImage)
        
        switch self {
        case .list:
            items = (
                "List",
                UIImage(named: "list")!,
                UIImage(named: "list")!
            )
        case .map:
            items = (
                "Map",
                UIImage(named: "map")!,
                UIImage(named: "map")!
            )
            case .profile:
            items = (
                "Profile",
                UIImage(named: "profile")!,
                UIImage(named: "profile")!
            )
        }
        
        let tabBarItem = UITabBarItem(
            title: items.0,
            image: items.1,
            selectedImage: items.2)
        
        return tabBarItem
    }
}
