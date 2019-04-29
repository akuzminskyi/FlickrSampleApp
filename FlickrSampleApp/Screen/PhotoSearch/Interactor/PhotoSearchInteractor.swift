//
//  PhotoSearchInteractor.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class PhotoSearchInteractor {
    private enum Error: Swift.Error, LocalizedError {
        case emptyText

        var errorDescription: String? {
            switch self {
            case .emptyText:
                return "Error_SearchTerm_Empty".localized()
            }
        }
    }

    private enum Constant {
        static let batchSize: Int = 20
        static let isSafeSearchEnabled = true
        static let firstPageIndex = 1
    }

    weak var output: PhotoSearchInteractorOutput?
    private let flickrService: FlickrServiceInterface
    private var actualSearchTerm: String? {
        didSet {
            fetchNextPagesQueue.removeAll()
            fetchedPage.removeAll()
        }
    }
    private var fetchNextPagesQueue = UniqueQueue<Int>()
    private var fetchedPage = Set<Int>()

    init(flickrService: FlickrServiceInterface) {
        self.flickrService = flickrService
    }

    // MARK: - private metods

    private func photoSearchAttributes(withPage page: Int) -> PhotoSearchAttributes {
        return PhotoSearchAttributes(batchSize: Constant.batchSize, page: page, isSafeSearch: Constant.isSafeSearchEnabled)
    }

    private func pageAt(index: Int, withBatchSize batchSize: Int) -> Int {
        guard batchSize > 0 else {
            assertionFailure("The batchSize have to be more then 0.")
            return index
        }
        return index / batchSize + 1
    }

    private func proceedFetchPageFromQueue() {
        guard let page = fetchNextPagesQueue.dequeue() else {
            return
        }
        fetchPhotosAt(page: page)
    }

    private func fetchPhotosAt(page: Int) {
        guard let text = actualSearchTerm else {
            return
        }
        flickrService.photoSearch(
            by: text,
            with: photoSearchAttributes(withPage: page),
            completionHandler: { [weak self] (result: Result<PaginatedResponse<Photo>, Swift.Error>) in
                guard let self = self, self.actualSearchTerm == text else {
                    return
                }

                switch result {
                case let .failure(error):
                    self.output?.fetchPhoto(at: page, completed: .failure(error))
                case let .success(paginatedResponse):
                    let startIndex = (paginatedResponse.page - 1) * Constant.batchSize
                    let range = startIndex..<(startIndex + paginatedResponse.result.count)
                    self.output?.fetchPhoto(at: page, completed: .success((range, paginatedResponse.result)))
                    self.fetchedPage.insert(page)
                }

                DispatchQueue.main.async {
                    self.proceedFetchPageFromQueue()
                }
            }
        )
    }
}

extension PhotoSearchInteractor: PhotoSearchInteractorInput {
    func fetchPhotos(by text: String) {
        guard !text.isEmpty else {
            self.output?.search(by: text, completed: .failure(Error.emptyText))
            return
        }
        actualSearchTerm = text
        flickrService.photoSearch(
            by: text,
            with: photoSearchAttributes(withPage: Constant.firstPageIndex),
            completionHandler: { [weak self] (result: Result<PaginatedResponse<Photo>, Swift.Error>) in
                guard let self = self, self.actualSearchTerm == text else {
                    return
                }
                switch result {
                case let .failure(error):
                    self.actualSearchTerm = nil
                    self.output?.search(by: text, completed: .failure(error))
                case let .success(paginatedResponse):
                    var photos = [Photo?](repeating: nil, count: paginatedResponse.total)
                    photos.replaceSubrange(0..<paginatedResponse.result.count, with: paginatedResponse.result)
                    self.output?.search(by: text, completed: .success(photos))
                    self.fetchedPage.insert(Constant.firstPageIndex)
                }
            }
        )
    }

    func fetchPhotosAt(indexes: [Int]) {
        indexes.map { index in
            return self.pageAt(index: index, withBatchSize: Constant.batchSize)
        }.orderedSet.filter { value -> Bool in
            !fetchedPage.contains(value)
        }.forEach { value in
            fetchNextPagesQueue.enqueue(value)
        }
        proceedFetchPageFromQueue()
    }
}
