//
//  CityService.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/24/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol CityServiceHandler {
    func fetchData(points: [String], _ completion: @escaping ([CityModel]?) -> Void)
}

class CityService: CityServiceHandler {
    private var reference = Database.database().reference()
    
    func fetchData(points: [String], _ completion: @escaping ([CityModel]?) -> Void) {
        var cities = [CityModel]()
        
        points.forEach { point in
            reference.child(point).observe(.value) { (snapshot) in
                if let dict = snapshot.value as? [String: Any],
                    let name = dict["name"] as? String {
                    cities.append(CityModel(identifier: point, name: name, latitude: dict["latitude"] as? Double, longitude: dict["longitude"] as? Double))
                }
                
                completion(cities)
            }
        }
    }
}
