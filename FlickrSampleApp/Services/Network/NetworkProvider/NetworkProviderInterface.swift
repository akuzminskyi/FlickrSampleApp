//
//  NetworkProviderInterface.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol NetworkProviderInterface: AnyObject {
    func downloadData(
        from url: URL,
        timeout: TimeInterval,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    )
}

extension NetworkProviderInterface {
    static var defaultTimeoutInterval: TimeInterval {
        return 5.0
    }

    func downloadData(from url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        downloadData(from: url, timeout: Self.defaultTimeoutInterval, completionHandler: completionHandler)
    }
}
