//
//  RegistrationViewModel.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/24/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import GoogleSignIn
import Firebase

protocol RegistrationViewModelDelegate {
    func signInVieGoogle(user: GIDGoogleUser?, error: Error?)
}

protocol RegistrationControllerDelegate: AnyObject {
    func presentTabBar(controller: TabBarViewController)
    func showErrorMessage()
}

protocol RegistrationFactory {
    func createTabBar() -> TabBarViewController
}

class RegistrationViewModel: RegistrationViewModelDelegate {
    // MARK: - Private properties
    private let factory: RegistrationFactory
    
    init(factory: RegistrationFactory) {
        self.factory = factory
    }
    
    // MARK: - Properties
    weak var view: RegistrationControllerDelegate?
    
    // MARK: - RegistrationViewModelDelegate
    func signInVieGoogle(user: GIDGoogleUser?, error: Error?) {
        guard error == nil else {
            view?.showErrorMessage()
            return
        }
        
        guard let token = user?.authentication.idToken, let accessToken = user?.authentication.accessToken else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: token, accessToken: accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credentials) { [weak self] (_, error) in
            guard error == nil else { return }
            guard let controller = self?.factory.createTabBar() else { return }
            self?.view?.presentTabBar(controller: controller)
        }
    }
}
