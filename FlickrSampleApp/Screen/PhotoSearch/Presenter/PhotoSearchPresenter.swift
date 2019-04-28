//
//  PhotoSearchPresenter.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class PhotoSearchPresenter {
    private enum Constant {
        static let throttleTimeout: TimeInterval = 0.5
    }

    private weak var view: PhotoSearchViewInput?
    private let interactor: PhotoSearchInteractorInput
    private let viewModelBuilder: PhotoSearchViewModelBuilderInterface
    private let searchThrottler = Throttler(timeout: Constant.throttleTimeout)

    init(
        view: PhotoSearchViewInput,
        interactor: PhotoSearchInteractorInput,
        viewModelBuilder: PhotoSearchViewModelBuilderInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.viewModelBuilder = viewModelBuilder
    }
}

extension PhotoSearchPresenter: PhotoSearchInteractorOutput {
    func search(by text: String, completed result: Result<[Photo?], Error>) {
        switch result {
        case let .failure(error):
            break
        case let .success(photos):
            let viewModels = viewModelBuilder.viewModels(from: photos)
            view?.showSearchResult(for: text, with: viewModels)
        }
    }

    func fetchPhoto(at index: Int, completed result: Result<(range: Range<Int>, photos: [Photo]), Error>) {

    }
}

extension PhotoSearchPresenter: PhotoSearchViewOutput {
    func onViewDidLoad() {
        view?.setSearchBarPlaceholder("PhotoSearch_SearchBar_Placeholder".localized())
    }

    func searchTextDidChange(_ text: String) {
        searchThrottler.throttle { [weak self] in
            self?.interactor.fetchPhotos(by: text)
        }
    }
}
