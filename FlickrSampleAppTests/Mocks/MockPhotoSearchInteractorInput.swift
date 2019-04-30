//
//  MockPhotoSearchInteractorInput.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 30/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation
@testable import FlickrSampleApp

final class MockPhotoSearchInteractorInput: PhotoSearchInteractorInput {
    private(set) var spyFetchPhotosByText = [String]()
    private(set) var spyfetchPhotosAtIndexes = [[Int]]()

    func fetchPhotos(by text: String) {
        spyFetchPhotosByText.append(text)
    }

    func fetchPhotosAt(indexes: [Int]) {
        spyfetchPhotosAtIndexes.append(indexes)
    }
}
