//
//  PhotoSearchPresenter.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class PhotoSearchPresenter {
    private weak var view: PhotoSearchViewInput?
    private let interactor: PhotoSearchInteractorInput

    init(
        view: PhotoSearchViewInput,
        interactor: PhotoSearchInteractorInput
    ) {
        self.view = view
        self.interactor = interactor
    }
}

extension PhotoSearchPresenter: PhotoSearchInteractorOutput {
    func search(by text: String, completed result: Result<[Photo?], Error>) {

    }

    func fetchPhoto(at index: Int, completed result: Result<(range: Range<Int>, photos: [Photo]), Error>) {

    }
}

extension PhotoSearchPresenter: PhotoSearchViewOutput {
    func onViewDidLoad() {

    }
}
