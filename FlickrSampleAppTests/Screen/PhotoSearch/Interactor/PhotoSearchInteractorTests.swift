//
//  PhotoSearchInteractorTests.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 30/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import XCTest
@testable import FlickrSampleApp

final class PhotoSearchInteractorTests: XCTestCase {
    private var interactor: PhotoSearchInteractor!
    private var mockedFlickrService: MockFlickrService!
    private var mockedOutput: MockInteractorOutput!

    override func setUp() {
        super.setUp()
        mockedOutput = MockInteractorOutput()
        mockedFlickrService = MockFlickrService()
        interactor = PhotoSearchInteractor(flickrService: mockedFlickrService)
        interactor.output = mockedOutput
    }

    override func tearDown() {
        mockedFlickrService = nil
        interactor = nil
        mockedOutput = nil
        super.tearDown()
    }

    private func stubbedPhotoSearchResponse(photoCount: Int = 1, total: Int = 1) -> PhotoSearchResponse {
        let photos = Array<Photo>(
            repeating: Photo(id: "fake", secret: "fake-secret", server: "fake-server", farm: 1),
            count: photoCount
        )
        return PhotoSearchResponse(photos:
            PaginatedResponse(
                page: 1,
                pages: 1,
                perpage: 1,
                total: total,
                result: photos
            )
        )
    }

    // MARK: - fetchPhotos

    func test_GivenEmptySearchText_WhenFetchPhotos_ThenFailureEmptyText() {
        interactor.fetchPhotos(by: "")

        guard case let .failure(error)? = mockedOutput.spySearchByTextCompleted.last?.result else {
            XCTFail("Expted failure")
            return
        }
        XCTAssertEqual(error.localizedDescription, "Search term can't be empty.")
    }

    func test_GivenStubSuccessResponse_AndSearchText_WhenFetchPhotos_ThenSuccessResponseWithPhotos() {
        let stubbedPhotoSearchResponse = self.stubbedPhotoSearchResponse()
        mockedFlickrService.stubbedResult = .success(stubbedPhotoSearchResponse)
        interactor.fetchPhotos(by: "sample")

        guard case let .success(data)? = mockedOutput.spySearchByTextCompleted.last?.result else {
            XCTFail("Expted failure")
            return
        }
        XCTAssertEqual(data, stubbedPhotoSearchResponse.photos.result)
    }

    func test_GivenStubFailureResponse_AndSearchText_WhenFetchPhotos_ThenSuccessResponseWithPhotos() {
        mockedFlickrService.stubbedResult = .failure(NSError(domain: "fake", code: -1, userInfo: nil))
        interactor.fetchPhotos(by: "sample")

        guard case let .failure(data)? = mockedOutput.spySearchByTextCompleted.last?.result else {
            XCTFail("Expted failure")
            return
        }
        XCTAssertEqual((data as NSError), NSError(domain: "fake", code: -1, userInfo: nil))
    }

    func test_GivenBatched1PhotoInSuccessResponse_AndSearchText_WhenFetchPhotos_ThenOnlyFirstWillExist() {
        let stubbedPhotoSearchResponse = self.stubbedPhotoSearchResponse(photoCount: 1, total: 3)
        mockedFlickrService.stubbedResult = .success(stubbedPhotoSearchResponse)
        interactor.fetchPhotos(by: "sample")

        guard case let .success(data)? = mockedOutput.spySearchByTextCompleted.last?.result else {
            XCTFail("Expted failure")
            return
        }
        XCTAssertEqual(
            data,
            [
                Photo(id: "fake", secret: "fake-secret", server: "fake-server", farm: 1),
                nil,
                nil
            ]
        )
    }

    // MARK: - fetchPhotos.attribues

    func test_GivenSearchText_WhenFetchPhotos_ThenBatchSizeIs20() {
        interactor.fetchPhotos(by: "sample")

        let result = mockedFlickrService.spyPhotoSearch.map { $0.attributes }.map { $0?.batchSize }
        XCTAssertEqual(result, [20])
    }

    func test_GivenSearchText_WhenFetchPhotos_ThenSafeSearchIsTrue() {
        interactor.fetchPhotos(by: "sample")

        let result = mockedFlickrService.spyPhotoSearch.map { $0.attributes }.map { $0?.isSafeSearch }
        XCTAssertEqual(result, [true])
    }

    func test_GivenSearchText_WhenFetchPhotos_ThenFirstPage() {
        interactor.fetchPhotos(by: "sample")

        let result = mockedFlickrService.spyPhotoSearch.map { $0.attributes }.map { $0?.page }
        XCTAssertEqual(result, [1])
    }
}
