//
//  AppDelegate.swift
//  MapTestProject
//
//  Created by Oksana Dionisieva on 12/23/19.
//  Copyright © 2019 Dioksa. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GIDSignIn.sharedInstance().clientID = "1082380577546-hal0vba7ibdmlilcb0mmtmk1c127npr1.apps.googleusercontent.com"
        // Override point for customization after application launch.
        return true
    }
}
