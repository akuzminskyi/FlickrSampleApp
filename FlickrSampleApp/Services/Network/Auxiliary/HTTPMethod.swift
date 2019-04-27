//
//  HTTPMethod.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete

    var stringValue: String {
        return rawValue
    }
}
