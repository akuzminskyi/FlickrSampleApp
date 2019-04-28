//
//  PhotoSearchInteractor.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class PhotoSearchInteractor {
    private enum Error: Swift.Error {
        case emptyText
    }

    private enum Constant {
        static let batchSize: Int = 20
        static let isSafeSearchEnabled = true
        static let firstPageIndex = 1
    }

    weak var output: PhotoSearchInteractorOutput?
    private let flickrService: FlickrServiceInterface
    private var lastSuccededTextSearch: String?
    private var batchSize: Int {
        return Constant.batchSize
    }

    init(flickrService: FlickrServiceInterface) {
        self.flickrService = flickrService
    }

    // MARK: - private metods

    private func photoSearchAttributes(withPage page: Int) -> PhotoSearchAttributes {
        return PhotoSearchAttributes(batchSize: batchSize, page: page, isSafeSearch: Constant.isSafeSearchEnabled)
    }

    private func pageAt(index: Int, withBatchSize batchSize: Int) -> Int {
        guard batchSize > 0 else {
            assertionFailure("The batchSize have to be more then 0.")
            return index
        }
        return index / batchSize
    }
}

extension PhotoSearchInteractor: PhotoSearchInteractorInput {
    func fetchPhotos(by text: String) {
        guard !text.isEmpty else {
            self.output?.search(by: text, completed: .failure(Error.emptyText))
            return
        }

        flickrService.photoSearch(
            by: text,
            with: photoSearchAttributes(withPage: Constant.firstPageIndex),
            completionHandler: { [weak self] (result: Result<PaginatedResponse<Photo>, Swift.Error>) in
                guard let self = self else {
                    return
                }

                switch result {
                case let .failure(error):
                    self.lastSuccededTextSearch = nil
                    self.output?.search(by: text, completed: .failure(error))
                case let .success(paginatedResponse):
                    self.lastSuccededTextSearch = text
                    var photos = [Photo?](repeating: nil, count: paginatedResponse.total)
                    photos.replaceSubrange(0..<paginatedResponse.result.count, with: paginatedResponse.result)
                    self.output?.search(by: text, completed: .success(photos))
                }
            }
        )
    }

    func fetchPhotos(at index: Int) {
        guard let text = lastSuccededTextSearch else {
            return
        }
        let page = self.pageAt(index: index, withBatchSize: batchSize)

        flickrService.photoSearch(
            by: text,
            with: photoSearchAttributes(withPage: page),
            completionHandler: { [weak self] (result: Result<PaginatedResponse<Photo>, Swift.Error>) in
                guard let self = self else {
                    return
                }

                switch result {
                case let .failure(error):
                    self.output?.fetchPhoto(at: index, completed: .failure(error))
                case let .success(paginatedResponse):
                    let startIndex = (paginatedResponse.page - 1) * self.batchSize
                    let range = startIndex..<(startIndex + paginatedResponse.result.count)
                    self.output?.fetchPhoto(at: index, completed: .success((range, paginatedResponse.result)))
                }
            }
        )
    }
}
