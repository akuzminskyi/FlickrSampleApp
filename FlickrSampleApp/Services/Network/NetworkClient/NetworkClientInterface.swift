//
//  NetworkClientInterface.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol NetworkClientInterface: AnyObject {
    associatedtype Method: ApiMethod

    var configuration: NetworkClientConfiguration { get }

    func request(
        to networkProvider: NetworkProviderInterface,
        for method: Method,
        with parameters: [URLQueryItem]?,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    )
}

extension NetworkClientInterface {
    func request(
        to networkProvider: NetworkProviderInterface,
        for method: Method,
        with parameters: [URLQueryItem]?,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) {
        guard var urlComponent = URLComponents(url: configuration.baseUrl, resolvingAgainstBaseURL: true) else {
            completionHandler(
                    .failure(NetworkError.invalidUrl(string: configuration.baseUrl.absoluteString))
            )
            return
        }

        var combinedParameters = method.query + [URLQueryItem(name: "api_key", value: configuration.apiKey)]
        if let unwrappedRarameters = parameters {
            combinedParameters.append(contentsOf: unwrappedRarameters)
        }

        if urlComponent.queryItems == nil {
            urlComponent.queryItems = combinedParameters
        } else {
            urlComponent.queryItems?.append(contentsOf: combinedParameters)
        }

        guard let newURL = urlComponent.url else {
            completionHandler(.failure(NetworkError.invalidUrlCompounding))
            return
        }

        networkProvider.downloadData(from: newURL, completionHandler: completionHandler)
    }
}
