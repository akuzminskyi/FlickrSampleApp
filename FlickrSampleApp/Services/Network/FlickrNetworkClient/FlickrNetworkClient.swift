//
//  FlickrNetworkClient.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class FlickrNetworkClient: NetworkClientInterface {
    typealias Method = FlickrMethod

    private let configuration: NetworkClientConfiguration
    private let networkProvider: NetworkProviderInterface

    private var predefinedParams: [URLQueryItem] {
        return [
            URLQueryItem(name: "api_key", value: configuration.apiKey),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1")
        ]
    }

    init(networkProvider: NetworkProviderInterface, configuration: NetworkClientConfiguration) {
        self.networkProvider = networkProvider
        self.configuration = configuration
    }
}

extension FlickrNetworkClient: FlickrNetworkClientInterface {
    func request(
        for method: FlickrMethod,
        with parameters: [URLQueryItem]?,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) {
        let combinedParameters = predefinedParams + method.query + (parameters ?? [])

        let request = NetworkRequest(
            baseUrl: configuration.baseUrl,
            parameters: combinedParameters,
            completionHandler: completionHandler
        )
        executeRequest(request, at: networkProvider)
    }
}
