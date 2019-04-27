//
//  ModuleBuilder.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

protocol ModuleRouterInterface {
    static func buildModule() throws -> UIViewController
}

extension ModuleRouterInterface {
    @discardableResult
    static func buildModule(into navigationController: UINavigationController) throws -> UIViewController {
        let viewController = try buildModule()
        navigationController.pushViewController(viewController, animated: true)
        return viewController
    }
}
