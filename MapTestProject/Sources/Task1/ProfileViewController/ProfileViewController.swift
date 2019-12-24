//
//  ProfileViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tabBarItem = TabBarItem.profile.makeTabBarItem()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = TabBarItem.profile.makeTabBarItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile screen"
    }
}
