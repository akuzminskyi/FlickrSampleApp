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

    var networkProvider: NetworkProviderInterface { get }
    var configuration: NetworkClientConfiguration { get }

    func request(
        for method: Method,
        parameters: [URLQueryItem]?,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    )
}

extension NetworkClientInterface {
    func request(
        for method: Method,
        parameters: [URLQueryItem]? = nil,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) {
        guard var urlComponent = URLComponents(url: configuration.baseUrl, resolvingAgainstBaseURL: true) else {
            completionHandler(
                    .failure(NetworkError.invalidUrl(string: configuration.baseUrl.absoluteString))
            )
            return
        }
        let combinedParameters = method.query + (parameters ?? [])

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
