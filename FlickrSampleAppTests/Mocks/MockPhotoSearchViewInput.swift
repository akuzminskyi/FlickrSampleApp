//
//  MockPhotoSearchViewInput.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 30/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation
@testable import FlickrSampleApp

final class MockPhotoSearchViewInput: PhotoSearchViewInput {
    private(set) var spySetSearchBarPlaceholder = [String?]()
    private(set) var spyShowSearchingIndicator = [Bool]()
    private(set) var spyShowError = [String]()

    func setSearchBarPlaceholder(_ text: String?) {
        spySetSearchBarPlaceholder.append(text)
    }

    func showSearchResult(for text: String, with viewModels: [PhotoViewModel]) {

    }

    func showUpdatedViewModels(_ viewModels: [PhotoViewModel], at range: Range<Int>) {

    }

    func showSearchingIndicator(_ isSearching: Bool) {
        spyShowSearchingIndicator.append(isSearching)
    }

    func showError(_ message: String) {
        spyShowError.append(message)
    }

    func hideError() {

    }
}
