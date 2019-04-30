//
//  FlickrNetworkClientTests.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 30/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import XCTest
@testable import FlickrSampleApp

final class FlickrNetworkClientTests: XCTestCase {
    private var client: FlickrNetworkClient!
    private var mockedNetworkProvider: MockNetworkProvider!
    private var stubbedConfiguration: NetworkClientConfiguration!

    override func setUp() {
        super.setUp()
        stubbedConfiguration = NetworkClientConfiguration(
            baseUrl: URL(staticString: "www.sample.com"),
            apiKey: "fake-api-key"
        )
        mockedNetworkProvider = MockNetworkProvider()
        client = FlickrNetworkClient(
            networkProvider: mockedNetworkProvider,
            configuration: stubbedConfiguration
        )
    }

    override func tearDown() {
        client = nil
        mockedNetworkProvider = nil
        stubbedConfiguration = nil
        super.tearDown()
    }

    // MARK: - request(for: with: completionHanlder:)

    func test_GivenSearchTextWithoutParameters_WhenRequest_ThenUrlIsCompleted() {
        let expectation = self.expectation(description: "Callback")
        client.request(
            for: .search(text: "sample"),
            with: nil
        ) { _ in
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.1)

        XCTAssertEqual(
            mockedNetworkProvider.spyDownloadData.map { $0.url },
            [URL(staticString: "www.sample.com?api_key=fake-api-key&format=json&nojsoncallback=1&method=flickr.photos.search&text=sample")]
        )
    }

    func test_GivenSearchText_AndParameters_WhenRequest_ThenUrlHasBothPredefinedAndPassedParameters() {
        let expectation = self.expectation(description: "Callback")
        client.request(
            for: .search(text: "sample"),
            with: [URLQueryItem(name: "key", value: "value")]
        ) { _ in
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.1)

        XCTAssertEqual(
            mockedNetworkProvider.spyDownloadData.map { $0.url },
            [URL(staticString: "www.sample.com?api_key=fake-api-key&format=json&nojsoncallback=1&method=flickr.photos.search&text=sample&key=value")]
        )
    }
}
