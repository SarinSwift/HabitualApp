//
//  AppDelegate.swift
//  Habitual
//
//  Created by Sarin Swift on 11/13/18.
//  Copyright © 2018 sarinswift. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // create and set the window to be the same size as the screen
        window = UIWindow(frame: UIScreen.main.bounds)

        // create an instance of the main view controller. loading the MainViewController.xib
        let navigationController = UINavigationController()
        let mainViewController = HabitsTableViewController.instantiate()
        navigationController.setViewControllers([mainViewController], animated: false)
        
        // tell the window to load the navigation controller as its root
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

