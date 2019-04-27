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
    var baseURL: URL { get }

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
        guard var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            completionHandler(.failure(NetworkError.invalidUrl(string: baseURL.absoluteString)))
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
