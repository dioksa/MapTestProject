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

class RegistrationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "MapTestProject"
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        addGoogleButton()
    }
    
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
        print(user)
        let controller = UIStoryboard.instantiateViewController(of: TabBarViewController.self)
        present(controller, animated: true, completion: nil)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
}
