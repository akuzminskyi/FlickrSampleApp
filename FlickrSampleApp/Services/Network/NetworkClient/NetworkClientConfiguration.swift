//
//  NetworkClientConfiguration.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

struct NetworkClientConfiguration {
    let baseUrl: URL
    let apiKey: String
}

extension NetworkClientConfiguration {
    init(from bundle: Bundle) throws {
        self.init(
            baseUrl: try bundle.flickrRestUrl(),
            apiKey: try bundle.flickrApiKey()
        )
    }
}

