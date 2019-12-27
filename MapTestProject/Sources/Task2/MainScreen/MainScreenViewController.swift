//
//  MainScreenViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/26/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

final class MainScreenViewController: UIViewController {
    @IBAction func handleRegistrationButtonTap(_ sender: UIButton) {
        let controller = UIStoryboard.instantiateViewController(of: RegisterViewController.self)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func handleDashboardButtonTap(_ sender: UIButton) {
        let controller = UIStoryboard.instantiateViewController(of: DashboardViewController.self)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func handleChartButtonTap(_ sender: UIButton) {
        let controller = UIStoryboard.instantiateViewController(of: ChartViewController.self)
        navigationController?.pushViewController(controller, animated: true)
    }
}
