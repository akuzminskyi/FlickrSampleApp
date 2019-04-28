//
//  FlickrPhotoURLBuilder.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 28/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

struct FlickrPhotoURLBuilder: FlickrPhotoURLBuilderInterface {
    func photoUrl(from photo: Photo) -> URL? {
        return URL(string: "http://farm\(photo.farm).static.flickr.com/\(photo.server)/{\(photo.id)_\(photo.secret).jpg")
    }
}
