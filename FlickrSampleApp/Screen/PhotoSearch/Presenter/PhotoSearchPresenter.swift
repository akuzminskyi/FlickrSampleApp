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
    private let searchThrottler: Throttler

    init(
        view: PhotoSearchViewInput,
        interactor: PhotoSearchInteractorInput,
        viewModelBuilder: PhotoSearchViewModelBuilderInterface,
        searchThrottler: Throttler = Throttler(timeout: Constant.throttleTimeout)
    ) {
        self.view = view
        self.interactor = interactor
        self.viewModelBuilder = viewModelBuilder
        self.searchThrottler = searchThrottler
    }
}

extension PhotoSearchPresenter: PhotoSearchInteractorOutput {
    func search(by text: String, completed result: Result<[Photo?], Error>) {
        view?.showSearchingIndicator(false)
        let viewModels: [PhotoViewModel]
        switch result {
        case let .failure(error):
            view?.showError(error.localizedDescription)
            viewModels = []
        case let .success(photos):
            view?.hideError()
            viewModels = viewModelBuilder.viewModels(from: photos)
        }
        view?.showSearchResult(for: text, with: viewModels)
    }

    func fetchPhoto(at page: Int, completed result: Result<(range: Range<Int>, photos: [Photo]), Error>) {
        switch result {
        case .failure(_):
            break
        case let .success((range, photos)):
            let viewModels = viewModelBuilder.viewModels(from: photos)
            view?.showUpdatedViewModels(viewModels, at: range)
        }
    }
}

extension PhotoSearchPresenter: PhotoSearchViewOutput {
    func onPrefetchItemAt(indexes: [Int]) {
        interactor.fetchPhotosAt(indexes: indexes)
    }

    func onViewDidLoad() {
        view?.setSearchBarPlaceholder("PhotoSearch_SearchBar_Placeholder".localized())
    }

    func searchTextDidChange(_ text: String) {
        searchThrottler.throttle { [weak self] in
            self?.view?.showSearchingIndicator(true)
            self?.interactor.fetchPhotos(by: text)
        }
    }
}
