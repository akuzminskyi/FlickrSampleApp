//
//  PhotoSearchPresenterTests.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 30/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import XCTest
@testable import FlickrSampleApp
final class PhotoSearchPresenterTests: XCTestCase {
    private var presenter: PhotoSearchPresenter!
    private var mockedViewModelBuilder: MockPhotoSearchViewModelBuilder!
    private var mockedInteractorInput: MockPhotoSearchInteractorInput!
    private var mockedViewInput: MockPhotoSearchViewInput!

    override func setUp() {
        super.setUp()
        mockedViewInput = MockPhotoSearchViewInput()
        mockedInteractorInput = MockPhotoSearchInteractorInput()
        mockedViewModelBuilder = MockPhotoSearchViewModelBuilder()
        presenter = PhotoSearchPresenter(
            view: mockedViewInput,
            interactor: mockedInteractorInput,
            viewModelBuilder: mockedViewModelBuilder,
            searchThrottler: Throttler(timeout: 0)
        )
    }

    override func tearDown() {
        mockedViewInput = nil
        mockedInteractorInput = nil
        mockedViewModelBuilder = nil
        presenter = nil
        super.tearDown()
    }

    // MARK: - stubs

    private func stubbedLocalizedError() -> NSError {
        return NSError(domain: "fake", code: -1, userInfo: [NSLocalizedDescriptionKey: "localized error message"])
    }

    private func stubbedPhotoViewModel() -> PhotoViewModel {
        return PhotoViewModel(imageUrl: URL(staticString: "dsdsad"))
    }

    // MARK: - onViewDidLoad

    func test_WhenOnViewDidLoad_ThenSearchBarHasPlaceholder() {
        presenter.onViewDidLoad()

        XCTAssertEqual(mockedViewInput.spySetSearchBarPlaceholder, ["Type something to explore the world"])
    }

    // MARK: - searchTextDidChange

    func test_WhenOnViewDidLoad_ThenShowActivityIndicator() {
        presenter.searchTextDidChange("sample")

        XCTAssertEqual(mockedViewInput.spyShowSearchingIndicator, [true])
    }

    func test_WhenOnViewDidLoad_ThenInteractorFetchPhotos() {
        presenter.searchTextDidChange("sample")

        XCTAssertEqual(mockedInteractorInput.spyFetchPhotosByText, ["sample"])
    }

    // MARK: - onPrefetchItemAt

    func test_GivenRepetedPrefetchIndexes_WhenOnPrefetchItemAt_ThenInteractorReceiveAllIndexes() {
        presenter.onPrefetchItemAt(indexes: [1, 2, 3])

        XCTAssertEqual(mockedInteractorInput.spyfetchPhotosAtIndexes, [[1, 2, 3]])
    }

    func test_GivenEmptyListOfIndexes_WhenOnPrefetchItemAt_ThenInteractorReceiveAllIndexes() {
        presenter.onPrefetchItemAt(indexes: [])

        XCTAssertEqual(mockedInteractorInput.spyfetchPhotosAtIndexes, [[]])
    }

    // MARK: - search(by: completed:).failure

    func test_GivenSearchFailure_WhenSearchCompleted_ThenHideSearchingIndicator() {
        presenter.search(by: "sample", completed: Result<[Photo?], Error>.failure(stubbedLocalizedError()))

        XCTAssertEqual(mockedViewInput.spyShowSearchingIndicator, [false])
    }

    func test_GivenSearchFailure_WhenSearchCompleted_ThenShowError() {
        presenter.search(by: "sample", completed: Result<[Photo?], Error>.failure(stubbedLocalizedError()))

        XCTAssertEqual(mockedViewInput.spyShowError, ["localized error message"])
    }

    // MARK: - search(by: completed:).success

    func test_GivenSearchSuccess_WhenSearchCompleted_ThenHideSearchingIndicator() {
        presenter.search(by: "sample", completed: Result<[Photo?], Error>.success([]))

        XCTAssertEqual(mockedViewInput.spyShowSearchingIndicator, [false])
    }

    func test_GivenSearchSuccess_WhenSearchCompleted_ThenSearchTextIsTheSame() {
        presenter.search(by: "sample", completed: Result<[Photo?], Error>.success([]))

        XCTAssertEqual(mockedViewInput.spyShowSearchResult.map { $0.text }, ["sample"])
    }

    func test_GivenSearchSuccess_WhenSearchCompleted_ThenViewModelHasStubbedURLFromViewModelBuilder() {
        presenter.search(by: "sample", completed: Result<[Photo?], Error>.success([]))

        XCTAssertEqual(
            mockedViewInput.spyShowSearchResult.map { $0.viewModels },
            [
                [PhotoViewModel(imageUrl: URL(staticString: "www.sample.com"))]
            ]
        )
    }
}
