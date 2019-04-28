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
}
extension PhotoSearchPresenter: PhotoSearchViewOutput {
    func onViewDidLoad() {

    }
}
