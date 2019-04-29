//
//  PhotoSearchViewInput.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol PhotoSearchViewInput: AnyObject {
    func setSearchBarPlaceholder(_ text: String?)
    func showSearchResult(for text: String, with viewModels: [PhotoViewModel])
    func showUpdatedViewModels(_ viewModels: [PhotoViewModel], at range: Range<Int>)
    func showSearchingIndicator(_ isSearching: Bool)
    func showError(_ message: String)
    func hideError()
}
