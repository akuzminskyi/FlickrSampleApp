//
//  MockFlickrService.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 30/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation
@testable import FlickrSampleApp

final class MockFlickrService: FlickrServiceInterface {
    private(set) var spyPhotoSearch = [(text: String, attributes: PhotoSearchAttributes?)]()
    var stubbedResult: Result<PhotoSearchResponse, Error>?

    func photoSearch(by text: String, with attributes: PhotoSearchAttributes?, completionHandler: @escaping ((Result<PhotoSearchResponse, Error>) -> Void)) {
        spyPhotoSearch.append((text, attributes))

        if let result = stubbedResult {
            completionHandler(result)
        }
    }
}
