//
//  FlickrMethodTests.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 30/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import XCTest
@testable import FlickrSampleApp
final class FlickrMethodTests: XCTestCase {

    func test_GivenSearchText_WhenQuery_ThenHasMethodPhotoSearch() {
        let result = FlickrMethod.search(text: "sample").query.first { item -> Bool in
            item.name == "method"
        }

        XCTAssertEqual(result?.value, "flickr.photos.search")
    }

    func test_GivenSearchText_WhenQuery_ThenHasText() {
        let result = FlickrMethod.search(text: "sample").query.first { item -> Bool in
            item.name == "text"
        }

        XCTAssertEqual(result?.value, "sample")
    }

    func test_GivenSearchText_WhenQuery_ThenHasTwoItems() {
        let result = FlickrMethod.search(text: "sample").query

        XCTAssertEqual(
            result,
            [
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "text", value: "sample")
            ]
        )
    }

    func test_GivenEmptySearchText_WhenQuery_ThenHasEmptyString() {
        let result = FlickrMethod.search(text: "").query

        XCTAssertEqual(
            result,
            [
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "text", value: "")
            ]
        )
    }
}
