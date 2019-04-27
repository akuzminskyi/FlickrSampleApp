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

    init(networkClient: FlickrNetworkClientInterface) {
        self.networkClient = networkClient
    }
}

extension FlickrService: FlickrServiceInterface {
    func photoSearch(by text: String, completionHandler: @escaping ((Result<PhotoSearchResponse, Error>) -> Void)) {
        networkClient.request(for: .search(text: text)) { result in
            let mainThreadCompletionHandler: (Result<PhotoSearchResponse, Error>) -> Void = { value in
                DispatchQueue.main.async {
                    completionHandler(value)
                }
            }
            JSONParser.parse(result: result, completionHandler: mainThreadCompletionHandler)
        }
    }
}
