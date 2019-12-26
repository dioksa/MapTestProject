//
//  Collection.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/26/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
