//
//  URL+StaticString.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 29/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        self = url
    }
}
