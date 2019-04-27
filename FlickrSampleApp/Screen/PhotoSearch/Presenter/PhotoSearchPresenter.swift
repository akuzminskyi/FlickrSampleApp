//
//  PhotoSearchPresenter.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class PhotoSearchPresenter {
    private weak var view: PhotoSearchViewInterface?
    private let interactor: PhotoSearchInteractorInterface

    init(
        view: PhotoSearchViewInterface,
        interactor: PhotoSearchInteractorInterface
    ) {
        self.view = view
        self.interactor = interactor
    }
}

extension PhotoSearchPresenter: PhotoSearchPresenterInterface {
    func onViewDidLoad() {

    }
}
