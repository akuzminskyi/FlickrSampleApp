//
//  PhotoSearchInteractorInput.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol PhotoSearchInteractorInput {
    func fetchPhotos(by text: String)
    func fetchPhotosAt(indexes: [Int])
}
