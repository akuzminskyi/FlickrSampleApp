//
//  FlickrMethod.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

enum FlickrMethod: ApiMethod {
    case search(text: String)

    var query: [URLQueryItem] {
        switch self {
        case let .search(text):
            return [
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "text", value: text),
            ]
        }
    }
}
