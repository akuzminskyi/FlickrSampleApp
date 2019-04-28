//
//  FlickrPhotoURLBuilderInterface.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 28/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol FlickrPhotoURLBuilderInterface {
    func photoUrl(from photo: Photo) -> URL?
}
