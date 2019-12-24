//
//  UIImage.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

extension UIImage {
    static func makeTabBarBackgroundImage(with size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, .zero)
        UIColor.red.setFill()
        UIRectFill(CGRect(x: .zero, y: .zero, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
