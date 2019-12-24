//
//  TopNavigationController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/24/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

class TopNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
}
