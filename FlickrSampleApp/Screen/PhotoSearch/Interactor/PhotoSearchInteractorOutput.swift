//
//  PhotoSearchInteractorOutput.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 28/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol PhotoSearchInteractorOutput: AnyObject {
    func search(by text: String, completed result: Result<[Photo?], Error>)

    func fetchPhoto(at index: Int, completed result: Result<(range: Range<Int>, photos: [Photo]), Error>)
}
