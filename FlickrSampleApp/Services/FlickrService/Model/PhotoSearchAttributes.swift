//
//  PhotoSearchAttributes.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 28/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

struct PhotoSearchAttributes: Queryable {
    let batchSize: Int
    let page: Int
    let isSafeSearch: Bool

    var query: [URLQueryItem] {
        return [
            URLQueryItem(name: "per_page", value: String(batchSize)),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "safe_search", value: isSafeSearch ? "1" : "0")
        ]
    }
}
