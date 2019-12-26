//
//  RegistrationViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit
import GoogleSignIn
import SnapKit
import Firebase

final class RegistrationViewController: UIViewController {
    // MARK: - Private properties
    private var viewModel: RegistrationViewModelDelegate?
    
    // MARK: - Controller's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "MapTestProject"
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        addGoogleButton()
    }
    
    // MARK: - Private methods
    private func addGoogleButton() {
        let button = GIDSignInButton()
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
    }
}

// MARK: - GIDSignInDelegate
extension RegistrationViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        viewModel?.signInVieGoogle(user: user, error: error)
    }
}

// MARK: - Injectable
extension RegistrationViewController: Injectable {
    struct Dependencies {
        let viewModel: RegistrationViewModelDelegate
    }
    
    func inject(dependencies: Dependencies) {
        viewModel = dependencies.viewModel
    }
}

// MARK: - RegistrationControllerDelegate
extension RegistrationViewController: RegistrationControllerDelegate {
    func showErrorMessage() {
        addAlertMessage(alertTitle: "Sorry, something goes wrong. Try again later")
    }
    
    func presentTabBar(controller: TabBarViewController) {
        present(controller, animated: true)
    }
}
