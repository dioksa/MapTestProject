//
//  ProfileViewController.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit
import Firebase

final class ProfileViewController: UIViewController {
    // MARK: - Private methods
    @IBAction private func signOutButton(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tabBarItem = TabBarItem.profile.makeTabBarItem()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = TabBarItem.profile.makeTabBarItem()
    }
    
    // MARK: - Controller's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile screen"
    }
}
