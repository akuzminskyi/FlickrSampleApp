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
