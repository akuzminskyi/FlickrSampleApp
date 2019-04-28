//
//  PhotoSearchInteractor.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

final class PhotoSearchInteractor {
    weak var output: PhotoSearchInteractorOutput?
    private let flickrService: FlickrServiceInterface

    init(flickrService: FlickrServiceInterface) {
        self.flickrService = flickrService
    }
}

extension PhotoSearchInteractor: PhotoSearchInteractorInput {

    }
}
