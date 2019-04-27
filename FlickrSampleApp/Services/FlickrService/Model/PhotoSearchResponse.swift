//
//  PhotoSearchResponse.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

struct PhotoSearchResponse: Decodable {
    let photos: PaginatedResponse<Photo>
}
