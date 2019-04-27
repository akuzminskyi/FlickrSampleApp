//
//  FlickrNetworkClientInterface.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol FlickrNetworkClientInterface: NetworkClientInterface {
    func request(
        for method: Method,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    )
}
