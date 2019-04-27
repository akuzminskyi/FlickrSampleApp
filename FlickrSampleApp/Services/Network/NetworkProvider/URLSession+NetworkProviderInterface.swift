//
//  URLSession+NetworkProviderInterface.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

extension URLSession: NetworkProviderInterface {

    func downloadData(
        from url: URL,
        timeout: TimeInterval,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) {
        func unexpectedErrorIfNil(_ error: Error?) -> Error {
            return error ?? networkDomainError(withLocalizedDescription: "Network_Error_UnexpectedError".localized())
        }

        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: timeout
        )
        request.httpMethod = HTTPMethod.get.stringValue

        let dataTask = self.dataTask(with: request) { [] (data, _, error) in
            guard let data = data, error == nil else {
                let returnError = unexpectedErrorIfNil(error)
                completionHandler(.failure(returnError))
                return
            }

            completionHandler(.success(data))
        }
        dataTask.resume()
    }

    // MARK: - private methods

    private func networkDomainError(withLocalizedDescription localizedDescription: String) -> Error {
        let domainError = [Bundle.main.bundleIdentifier, "network"].compactMap { $0 }.joined(separator: ".")
        return NSError(domain: domainError, code: -1, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}
