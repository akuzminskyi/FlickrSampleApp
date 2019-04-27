//
//  NetworkError.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl(string: String)
    case invalidUrlCompounding
    case unexpectedError
}
