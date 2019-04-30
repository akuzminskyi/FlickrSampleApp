//
//  Photo.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

struct Photo: Decodable, Equatable {
    let id: String
    let secret: String
    let server: String
    let farm: Int
}
