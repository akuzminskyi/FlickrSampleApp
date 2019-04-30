//
//  NetworkProviderInterfaceTests.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 30/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import XCTest
@testable import FlickrSampleApp

final class NetworkProviderInterfaceTests: XCTestCase {
    private var networkProvider: MockNetworkProvider!

    override func setUp() {
        super.setUp()
        networkProvider = MockNetworkProvider()
    }

    override func tearDown() {
        networkProvider = nil
        super.tearDown()
    }

    // MARK: - downloadData(from: completionHandler:)

    func test_GivenDefaultTimeout_WhenDownloadData_ThenTimeoutIs5Seconds() {
        let stubbedURL = URL(staticString: "www.sample.com")
        let expectation = self.expectation(description: "Callback")

        networkProvider.downloadData(from: stubbedURL) { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)

        XCTAssertEqual(networkProvider.spyDownloadData.map { $0.timeout }, [5])
    }
}
