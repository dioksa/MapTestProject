//
//  DashboardViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/26/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit
import SnapKit

final class DashboardViewController: UIViewController {
    
    @IBOutlet weak var progressBar2012: UIProgressView!
    @IBOutlet weak var progressBar2013: UIProgressView!
    @IBOutlet weak var progressBar2014: UIProgressView!
    @IBOutlet weak var progressBar2015: UIProgressView!
    @IBOutlet weak var progressBar2016: UIProgressView!
    @IBOutlet weak var progressBar2017: UIProgressView!
    @IBOutlet weak var progressBar2018: UIProgressView!
    
    @IBOutlet weak var statisticsView: UIView!
    
    private let roundView = CircularProgressView()
    
    private lazy var allBars = [
        progressBar2012,
        progressBar2013,
        progressBar2014,
        progressBar2015,
        progressBar2016,
        progressBar2017,
        progressBar2018
    ]
    
    @IBAction func handleBakcButtonTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allBars.forEach {
            guard let bar = $0 else { return }
            bar.transform = CGAffineTransform(rotationAngle: .pi / -2)
        }
        
        statisticsView.addSubview(roundView)
        
        roundView.snp.makeConstraints { make in
            make.top.equalTo(statisticsView.snp.top).offset(26.0)
            make.left.equalTo(statisticsView.snp.left).offset(30.0)
        }
        
        roundView.progressAnimation(duration: 0.01)
    }
}
