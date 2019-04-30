//
//  MockPhotoSearchViewModelBuilder.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 30/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation
@testable import FlickrSampleApp

final class MockPhotoSearchViewModelBuilder: PhotoSearchViewModelBuilderInterface {
    var stubbedViewModels = [PhotoViewModel(imageUrl: URL(staticString: "www.sample.com"))]

    func viewModels(from photos: [Photo?]) -> [PhotoViewModel] {
        return stubbedViewModels
    }
}
