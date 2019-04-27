//
//  NetworkRequest.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

struct NetworkRequest {
    let baseUrl: URL
    let parameters: [URLQueryItem]?
    let completionHandler: (Result<Data, Error>) -> Void
}
