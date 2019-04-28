//
//  PhotoSearchViewModelBuilder.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 28/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

struct PhotoSearchViewModelBuilder {
    private let photoUrlBuilder: FlickrPhotoURLBuilderInterface

    init(photoUrlBuilder: FlickrPhotoURLBuilderInterface) {
        self.photoUrlBuilder = photoUrlBuilder
    }
}

extension PhotoSearchViewModelBuilder: PhotoSearchViewModelBuilderInterface {
    func viewModels(from photos: [Photo?]) -> [PhotoViewModel] {
        return photos.map { photo in
            if let photo = photo {
                return PhotoViewModel(imageUrl: photoUrlBuilder.photoUrl(from: photo))
            } else {
                return PhotoViewModel(imageUrl: nil)
            }
        }
    }
}
