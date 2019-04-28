//
//  PhotoSearchViewOutput.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol PhotoSearchViewOutput: AnyObject {
    func onViewDidLoad()

    func searchTextDidChange(_ text: String)
    func onPrefetchItemAt(indexes: [Int])
}
