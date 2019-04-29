//
//  FlickrPhotoURLBuilderTest.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 29/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import XCTest
@testable import FlickrSampleApp

final class FlickrPhotoURLBuilderTest: XCTestCase {
    private var builder: FlickrPhotoURLBuilder!

    override func setUp() {
        super.setUp()
        builder = FlickrPhotoURLBuilder()
    }

    override func tearDown() {
        builder = nil
        super.tearDown()
    }

    // MARK: - stubs

    private func stubPhoto(
        id: String = "fake-id",
        secret: String = "fake-secret",
        server: String = "fake-server",
        farm: Int = 1
    ) -> Photo {
        return Photo(id: id, secret: secret, server: server, farm: farm)
    }

    // MARK: - photoUrl

    func test_GivenEmptyId_WhenPhotoUrl_ThenHasURL() {
        let url = builder.photoUrl(from: stubPhoto(id: ""))

        XCTAssertEqual(
            url,
            URL(staticString: "https://farm1.static.flickr.com/fake-server/_fake-secret.jpg")
        )
    }

    func test_GivenEmptySecret_WhenPhotoUrl_ThenHasURL() {
        let url = builder.photoUrl(from: stubPhoto(secret: ""))

        XCTAssertEqual(
            url,
            URL(staticString: "https://farm1.static.flickr.com/fake-server/fake-id_.jpg")
        )
    }

    func test_GivenEmptyServer_WhenPhotoUrl_ThenHasURL() {
        let url = builder.photoUrl(from: stubPhoto(server: ""))

        XCTAssertEqual(
            url,
            URL(staticString: "https://farm1.static.flickr.com//fake-id_fake-secret.jpg")
        )
    }

    func test_GivenNotEmptyValues_WhenPhotoUrl_ThenHasURL() {
        let url = builder.photoUrl(from: stubPhoto())

        XCTAssertEqual(
            url,
            URL(staticString: "https://farm1.static.flickr.com/fake-server/fake-id_fake-secret.jpg")
        )
    }

    func test_GivenFarm99_WhenPhotoUrl_ThenUrlHas99Farm() {
        let url = builder.photoUrl(from: stubPhoto(farm: 99))

        XCTAssertEqual(
            url,
            URL(staticString: "https://farm99.static.flickr.com/fake-server/fake-id_fake-secret.jpg")
        )
    }
}
