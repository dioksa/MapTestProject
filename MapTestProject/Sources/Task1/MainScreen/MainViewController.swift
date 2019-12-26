//
//  MainViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit
import Firebase

protocol Injectable {
    associatedtype Dependencies
}

protocol SetInjectable: Injectable {
    func inject(dependencies: Dependencies)
}

private enum Constants {
    static let size: CGFloat = 40.0
    static let originY: CGFloat = 20.0
    static let delay = 0.25
    static let duration: TimeInterval = 2
}

final class MainViewController: UIViewController {
    // MARK: - Private variables
    private let container = DependencyContainer()
    
    @IBOutlet private weak var topButton: UIButton! {
        didSet {
            UIView.animate(withDuration: Constants.duration, animations: { [weak self] in
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
    
    @IBAction private func topButtonAction(_ sender: UIButton) {
        if Auth.auth().currentUser == nil {
            let navigationController = container.createNavigationController()
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        } else {
            let controller = container.createTabBarController()
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction private func bottomButtonAction(_ sender: UIButton) {
        print("Bottom button was tapped")
    }
}
