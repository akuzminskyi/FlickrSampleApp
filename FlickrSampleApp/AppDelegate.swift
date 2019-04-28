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

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let applicationRouter = ApplicationRouter(window: window)
        applicationRouter.start()

        window.makeKeyAndVisible()
        return true
    }
}
