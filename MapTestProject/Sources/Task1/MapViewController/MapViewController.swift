//
//  MapViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
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
        navigationItem.title = "Map screen"
    }
}
