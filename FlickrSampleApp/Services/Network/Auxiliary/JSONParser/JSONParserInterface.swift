//
//  JSONParserInterface.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 30/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

protocol JSONParserInterface {
    func parse<T: Decodable>(
        result: Result<Data, Error>,
        via decoder: JSONDecoder,
        completionHandler: @escaping (Result<T, Error>) -> Void
    )
}

extension JSONParserInterface {
    func parse<T: Decodable>(
        result: Result<Data, Error>,
        completionHandler: @escaping (Result<T, Error>) -> Void
    ) {
        parse(result: result, via: JSONDecoder(), completionHandler: completionHandler)
    }
}
