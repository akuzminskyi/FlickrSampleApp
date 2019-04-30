//
//  FlickrService.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class FlickrService {
    private let networkClient: FlickrNetworkClientInterface
    private let jsonParser: JSONParserInterface

    init(networkClient: FlickrNetworkClientInterface, jsonParser: JSONParserInterface) {
        self.networkClient = networkClient
        self.jsonParser = jsonParser
    }
}

extension FlickrService: FlickrServiceInterface {
    func photoSearch(by text: String, with attributes: PhotoSearchAttributes?, completionHandler: @escaping ((Result<PhotoSearchResponse, Error>) -> Void)) {
        networkClient.request(for: .search(text: text), with: attributes?.query) { [weak self] result in
            let mainThreadCompletionHandler: (Result<PhotoSearchResponse, Error>) -> Void = { value in
                DispatchQueue.main.async {
                    completionHandler(value)
                }
            }
            self?.jsonParser.parse(result: result, completionHandler: mainThreadCompletionHandler)
        }
    }
}
