//
//  String+Localizable.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

extension String {
    public func localized(inBundle bundle: Bundle = .main) -> String {
        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}
