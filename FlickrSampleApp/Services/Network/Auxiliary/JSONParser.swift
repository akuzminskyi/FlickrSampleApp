//
//  JSONParser.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

enum JSONParser {
    static func parse<T: Decodable>(
        result: Result<Data, Error>,
        via decoder: JSONDecoder = JSONDecoder(),
        completionHandler: @escaping (Result<T, Error>) -> Void
    ) {
        switch result {
        case .success(let data):
            do {
                let object = try decoder.decode(T.self, from: data)
                completionHandler(.success(object))
            } catch let error {
                completionHandler(.failure(error))
            }
        case .failure(let error):
            completionHandler(.failure(error))
        }
    }
}
