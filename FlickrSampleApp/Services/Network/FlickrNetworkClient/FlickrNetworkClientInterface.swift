//
//  FlickrNetworkClientInterface.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol FlickrNetworkClientInterface {
    func request(
        for method: FlickrMethod,
        with parameters: [URLQueryItem]?,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    )
}

extension FlickrNetworkClientInterface {
    func request(
        for method: FlickrMethod,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) {
        request(for: method, with: nil, completionHandler: completionHandler)
    }
}
