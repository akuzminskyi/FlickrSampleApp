//
//  UIStoryboard+Generic.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func instantiateInitialViewController<T: UIViewController>() -> T {
        return instantiateInitialViewController() as! T
    }

    func instantiateViewController<T: UIViewController>(withIdentifier identifier: String =
        String(describing: T.self)) -> T {
        return instantiateViewController(withIdentifier: identifier) as! T
    }
}
