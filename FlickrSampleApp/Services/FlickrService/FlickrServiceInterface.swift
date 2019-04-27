//
//  FlickrServiceInterface.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol FlickrServiceInterface {
    func photoSearch(by text: String, completionHandler: @escaping ((Result<PhotoSearchResponse, Error>) -> Void))
}

extension FlickrServiceInterface {
    func photosSearch(by text: String, completionHandler: @escaping ((Result<PaginatedResponse<Photo>, Error>) -> Void)) {
        photoSearch(by: text) { (result: Result<PhotoSearchResponse, Error>) in
            switch result {
            case let .failure(error):
                completionHandler(.failure(error))
            case let .success(paginatedResponse):
                completionHandler(.success(paginatedResponse.photos))
            }
        }
    }
}
