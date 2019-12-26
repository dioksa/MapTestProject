//
//  UIViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/24/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

extension UIViewController {
    func addAlertMessage(alertTitle: String, message: String? = "", handler: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: handler)
            alert.addAction(OKAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
