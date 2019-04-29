//
//  NSCache+ImageCache.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 29/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

extension NSCache where KeyType == NSURL, ObjectType == UIImage {
    static let sharedImageCache = NSCache<NSURL, UIImage>()
}
