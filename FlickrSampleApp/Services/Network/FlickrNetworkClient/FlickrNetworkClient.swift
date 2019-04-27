//
//  FlickrNetworkClient.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class FlickrNetworkClient {
    typealias Method = FlickrMethod

    let configuration: NetworkClientConfiguration
    let networkProvider: NetworkProviderInterface

    init(networkProvider: NetworkProviderInterface, configuration: NetworkClientConfiguration) {
        self.networkProvider = networkProvider
        self.configuration = configuration
    }
}

extension FlickrNetworkClient: FlickrNetworkClientInterface {
    func request(for method: FlickrMethod, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        request(to: networkProvider, for: method, with: nil, completionHandler: completionHandler)
    }
}
