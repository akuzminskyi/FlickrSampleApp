//
//  PhotoSearchAttributesTest.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 29/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import XCTest
@testable import FlickrSampleApp

final class PhotoSearchAttributesTest: XCTestCase {

    // MARK: - stubs

    private func photoSearchAttributes(
        batchSize: Int = 1,
        page: Int = 2,
        isSafeSearch: Bool = true
    ) -> PhotoSearchAttributes {
        return PhotoSearchAttributes(batchSize: batchSize, page: page, isSafeSearch: isSafeSearch)
    }


    // MARK: - query

    func test_WhenQuery_ThenQueryHasPerPage() {
        let queryItem = photoSearchAttributes().query.first { query -> Bool in
            query.name == "per_page"
        }

        XCTAssertEqual(queryItem, URLQueryItem(name: "per_page", value: "1"))
    }

    func test_WhenQuery_ThenQueryHasPage() {
        let queryItem = photoSearchAttributes().query.first { query -> Bool in
            query.name == "page"
        }

        XCTAssertEqual(queryItem, URLQueryItem(name: "page", value: "2"))
    }

    func test_GivenSafeSearchFalse_WhenQuery_ThenSafeSearchIs0() {
        let queryItem = photoSearchAttributes(isSafeSearch: false).query.first { query -> Bool in
            query.name == "safe_search"
        }

        XCTAssertEqual(queryItem, URLQueryItem(name: "safe_search", value: "0"))
    }

    func test_GivenSafeSearchTrue_WhenQuery_ThenSafeSearchIs1() {
        let queryItem = photoSearchAttributes(isSafeSearch: true).query.first { query -> Bool in
            query.name == "safe_search"
        }

        XCTAssertEqual(queryItem, URLQueryItem(name: "safe_search", value: "1"))
    }

    func test_WhenQuery_ThenHas3Items() {
        XCTAssertEqual(
            photoSearchAttributes().query,
            [
                URLQueryItem(name: "per_page", value: "1"),
                URLQueryItem(name: "page", value: "2"),
                URLQueryItem(name: "safe_search", value: "1")
            ]
        )
    }
}
