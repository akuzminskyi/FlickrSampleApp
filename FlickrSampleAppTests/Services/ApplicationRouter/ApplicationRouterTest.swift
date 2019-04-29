//
//  ApplicationRouterTest.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 29/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import XCTest
@testable import FlickrSampleApp

final class ApplicationRouterTest: XCTestCase {
    private var router: ApplicationRouter!
    private var stubbedWindow: UIWindow!

    override func setUp() {
        super.setUp()
        stubbedWindow = UIWindow()
        router = ApplicationRouter(window: stubbedWindow)
    }

    override func tearDown() {
        router = nil
        stubbedWindow = nil
        super.tearDown()
    }

    // MARK: - start

    func test_WhenStart_ThenRootViewControllerIsNavigationControler() {
        router.start()

        XCTAssertTrue(stubbedWindow.rootViewController is UINavigationController)
    }

    func test_WhenStart_ThenTopViewControllerIsPhotoSearch() {
        router.start()

        let navigationController = stubbedWindow.rootViewController as? UINavigationController
        XCTAssertTrue(navigationController?.topViewController is PhotoSearchViewController)
    }
}
