//
//  ApplicationRouter.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 28/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

final class ApplicationRouter {
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension ApplicationRouter: ApplicationRouterInterface {
    func start() {
        guard let viewController = try? PhotoSearchRouter.buildModule() else {
            assertionFailure("Can't build a module")
            window.rootViewController = UIViewController()
            return
        }
        window.rootViewController = UINavigationController(rootViewController: viewController)
    }
}
