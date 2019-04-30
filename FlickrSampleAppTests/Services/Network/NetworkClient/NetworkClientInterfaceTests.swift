//
//  NetworkClientInterfaceTests.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 30/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import XCTest
@testable import FlickrSampleApp

final class NetworkClientInterfaceTests: XCTestCase {
    private var mockedNetworkProvider: MockNetworkProvider!
    private var client: MockNetworkClient!

    override func setUp() {
        super.setUp()
        mockedNetworkProvider = MockNetworkProvider()
        client = MockNetworkClient()
    }

    override func tearDown() {
        mockedNetworkProvider = nil
        client = nil
        super.tearDown()
    }

    // MARK: - stubs

    private func networkRequest(with parameters: [URLQueryItem]? = nil) -> NetworkRequest {
        let stubbedUrl = URL(staticString: "www.sample.com")
        return NetworkRequest(baseUrl: stubbedUrl, parameters: parameters, completionHandler: { _ in })
    }

    // MARK: - executeRequest

    func test_GivenNoneParameters_WhenExecuteRequest_ThenProviderHasUrlWithoutParameters() {
        let request = networkRequest(with: nil)

        client.executeRequest(request, at: mockedNetworkProvider)

        XCTAssertEqual(
            mockedNetworkProvider.spyDownloadData.map { $0.url },
            [URL(staticString: "www.sample.com")]
        )
    }

    func test_GivenSomeParameters_WhenExecuteRequest_ThenProviderHasUrlParameters() {
        let request = networkRequest(with: [
            URLQueryItem(name: "key1", value: "value1"),
            URLQueryItem(name: "key2", value: "value2"),
        ])

        client.executeRequest(request, at: mockedNetworkProvider)

        XCTAssertEqual(
            mockedNetworkProvider.spyDownloadData.map { $0.url },
            [URL(staticString: "www.sample.com?key1=value1&key2=value2")]
        )
    }

    func test_WhenExecuteRequest_ThenTimeoutIs5Seconds() {
        client.executeRequest(networkRequest(), at: mockedNetworkProvider)

        XCTAssertEqual(
            mockedNetworkProvider.spyDownloadData.map { $0.timeout },
            [5.0]
        )
    }
}

final private class MockNetworkClient: NetworkClientInterface { }
