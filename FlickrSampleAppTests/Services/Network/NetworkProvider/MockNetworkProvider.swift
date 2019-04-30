//
//  MockNetworkProvider.swift
//  FlickrSampleAppTests
//
//  Created by Andrii Kuzminskyi on 30/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation
@testable import FlickrSampleApp

final class MockNetworkProvider: NetworkProviderInterface {
    private(set) var spyDownloadData = [(url: URL, timeout: TimeInterval)]()
    var stubbeddDownloadDataResult: Result<Data, Error> = .success(Data())

    func downloadData(
        from url: URL,
        timeout: TimeInterval,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) {
        spyDownloadData.append((url, timeout))
        completionHandler(stubbeddDownloadDataResult)
    }
}
