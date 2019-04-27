//
//  AppDelegate.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 26/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        if let viewController = try? PhotoSearchRouter.buildModule() {
            window?.rootViewController = UINavigationController(rootViewController: viewController)
        } else {
            assertionFailure("Can't build a module")
            window?.rootViewController = UIViewController()
        }
        window?.makeKeyAndVisible()

        return true
    }


}

