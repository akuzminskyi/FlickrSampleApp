//
//  MockInteractorOutput.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 30/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation
@testable import FlickrSampleApp

final class MockInteractorOutput: PhotoSearchInteractorOutput {
    private(set) var spySearchByTextCompleted = [(text: String, result: Result<[Photo?], Error>)]()

    func search(by text: String, completed result: Result<[Photo?], Error>) {
        spySearchByTextCompleted.append((text, result))
    }

    func fetchPhoto(at page: Int, completed result: Result<(range: Range<Int>, photos: [Photo]), Error>) { }
}
