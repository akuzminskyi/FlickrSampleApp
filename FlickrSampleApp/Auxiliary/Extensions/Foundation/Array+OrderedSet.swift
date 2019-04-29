//
//  Array+OrderedSet.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 29/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    var orderedSet: Array<Element> {
        return NSOrderedSet(array: self).array as? Array ?? []
    }
}
