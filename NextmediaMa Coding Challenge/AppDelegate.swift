//
//  AppDelegate.swift
//  NextmediaMa Coding Challenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = UINavigationController(rootViewController: IndexController())
        self.window?.makeKeyAndVisible()
        
        return true
    }
    


}

