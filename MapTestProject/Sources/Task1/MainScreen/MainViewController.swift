//
//  MainViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit

private enum Constants {
    static let size: CGFloat = 40.0
    static let originY: CGFloat = 20.0
    static let delay = 0.25
    static let duration: TimeInterval = 1
}

class MainViewController: UIViewController {
    // MARK: - Private variables
    @IBOutlet private weak var topButton: UIButton! {
        didSet {
            UIView.animate(withDuration: 1, animations: { [weak self] in
                self?.topButton.backgroundColor = .red
                self?.topButton.frame.size.width += Constants.size
                self?.topButton.frame.size.height += Constants.size
            }) { _ in
                UIView.animate(withDuration: Constants.duration ,delay: Constants.delay, options: [.autoreverse], animations: { [weak self] in
                    self?.topButton.frame.origin.y -= Constants.originY
                })
            }
        }
    }
    
    @IBOutlet private weak var bottomButton: UIButton! {
        didSet {
            UIView.animate(withDuration: Constants.duration, animations: { [weak self] in
                self?.bottomButton.backgroundColor = .red
                self?.bottomButton.frame.size.width -= Constants.size
                self?.bottomButton.frame.size.height -= Constants.size
            }) { _ in
                UIView.animate(withDuration: Constants.duration, delay: Constants.delay, options: [.autoreverse], animations: { [weak self] in
                    self?.bottomButton.frame.origin.y += Constants.originY
                })
            }
        }
    }
    
    @IBAction func topButtonAction(_ sender: UIButton) {
        let controller = UIStoryboard.instantiateViewController(of: RegistrationViewController.self)
        let navigation = BaseNavigationController(rootViewController: controller)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true, completion: nil)
    }
    
    
    @IBAction func bottomButtonAction(_ sender: UIButton) {
        print("Button button was tapped")
    }
    
    // MARK: - Controller's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
