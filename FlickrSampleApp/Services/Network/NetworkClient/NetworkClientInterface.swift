//
//  NetworkClientInterface.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol NetworkClientInterface: AnyObject {
    func executeRequest(_ request: NetworkRequest, at networkProvider: NetworkProviderInterface)
}

extension NetworkClientInterface {
    func executeRequest(_ request: NetworkRequest, at networkProvider: NetworkProviderInterface) {
        guard var urlComponent = URLComponents(url: request.baseUrl, resolvingAgainstBaseURL: true) else {
            request.completionHandler(
                    .failure(NetworkError.invalidUrl(string: request.baseUrl.absoluteString))
            )
            return
        }

        if urlComponent.queryItems == nil {
            urlComponent.queryItems = request.parameters
        } else if let parameters = request.parameters {
            urlComponent.queryItems?.append(contentsOf: parameters)
        }

        guard let newURL = urlComponent.url else {
            request.completionHandler(.failure(NetworkError.invalidUrlCompounding))
            return
        }

        networkProvider.downloadData(from: newURL, completionHandler: request.completionHandler)
    }
}
