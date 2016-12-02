//
//  AppDelegate.swift
//  Avaliador
//
//  Created by Daniel Bonates on 29/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootViewController = LoginViewController()
        
//        let rootViewController = AvaliationViewController(for: User(name: "dbo", email: "dbo@dba.com")!)
        
//        let rootViewController = EndScreen()
//        rootViewController.userRate = 70
//        rootViewController.user = User(name: "dbo", email: "dbo@dba.com", score: 70)
        
        
        let mainNavigationController = UINavigationController(rootViewController: rootViewController)
        mainNavigationController.isNavigationBarHidden = true
        window?.rootViewController = mainNavigationController
        
        window?.makeKeyAndVisible()
        UIApplication.shared.statusBarStyle = .lightContent
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }


}

