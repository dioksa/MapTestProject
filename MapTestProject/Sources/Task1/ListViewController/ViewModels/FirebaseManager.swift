//
//  FirebaseManager.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/24/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseManager {
    static let shared = FirebaseManager()
    private let reference = Database.database().reference()
    
    func removeCity(point: String) {
        let ref = reference.child(point)
        ref.removeValue()
    }
}
