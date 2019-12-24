//
//  ProfileViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class ProfileViewController: UIViewController {    
    @IBAction func signOutButton(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        dismiss(animated: true) { [weak self] in
            let controller = UIStoryboard.instantiateViewController(of: RegistrationViewController.self)
            let navigation = BaseNavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            self?.present(navigation, animated: true, completion: nil)
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tabBarItem = TabBarItem.profile.makeTabBarItem()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = TabBarItem.profile.makeTabBarItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile screen"
    }
}
