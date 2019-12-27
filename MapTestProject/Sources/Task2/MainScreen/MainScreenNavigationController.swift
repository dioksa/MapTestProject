//
//  MainScreenNavigationController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/26/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

final class MainScreenNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor(red: 30/255, green: 30/255, blue: 46/255, alpha: 1.0)
        navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.layoutIfNeeded()
    }
}
