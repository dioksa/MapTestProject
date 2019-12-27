//
//  CircularProgressView.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/27/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

class CircularProgressView: UIView {

    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    
    private func createCircularPath() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: 30.0, y: 40.0), radius: 32, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 12.0
        circleLayer.strokeColor = UIColor(red: 69.0/225.0, green: 71.0/225.0, blue: 90.0/255.0, alpha: 1.0).cgColor
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 12.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor(red: 31.0/225.0, green: 142.0/225.0, blue: 241.0/255.0, alpha: 1.0).cgColor
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }
    
    func progressAnimation(duration: TimeInterval) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 0.5
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
