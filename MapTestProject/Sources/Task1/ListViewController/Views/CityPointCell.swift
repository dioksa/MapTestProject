//
//  CityPointCell.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/24/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

final class CityPointCell: UITableViewCell {
    // MARK: - Private properties
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var latitudeLabel: UILabel!
    @IBOutlet private weak var longitudeLabel: UILabel!
    
    // MARK: - Methods
    func configureCell(with model: CityModel) {
        clearFields()
        cityNameLabel.text = model.name
        
        if let latitude = model.latitude {
            latitudeLabel.text = String(latitude)
        } else {
            latitudeLabel.text = " - "
        }
        
        if let longitude = model.longitude {
            longitudeLabel.text = String(longitude)
        } else {
            longitudeLabel.text = " - "
        }
    }
    
    // MARK: - Private methods
    private func clearFields() {
        cityNameLabel.text = nil
        latitudeLabel.text = nil
        longitudeLabel.text = nil
    }
}
