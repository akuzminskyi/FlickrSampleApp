//
//  Bundle+Variables.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

extension Bundle {
    enum ConfigurationError: Error {
        case missedKey
        case invalidType
    }

    func flickrApiKey() throws -> String {
        guard let value = infoDictionary?["FLICKR_API_KEY"] else {
            throw ConfigurationError.missedKey
        }
        guard let stringValue = value as? String else {
            throw ConfigurationError.invalidType
        }
        return stringValue
    }

    func flickrRestUrl() throws -> URL {
        guard let value = infoDictionary?["FLICKR_REST_URL"] else {
            throw ConfigurationError.missedKey
        }
        guard let stringValue = value as? String, let url = URL(string: stringValue) else {
            throw ConfigurationError.invalidType
        }
        return url
    }
}
