//
//  PaginatedResponse.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import Foundation

struct PaginatedResponse<T: Decodable>: Decodable {
    enum Error: Swift.Error, LocalizedError {
        case unexpectedTotalValue

        var errorDescription: String? {
            switch self {
            case .unexpectedTotalValue:
                return "PaginatedResponse_Error_UnexpectedTotalValue".localized()
            }
        }
    }

    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let result: [T]

    private enum CodingKeys: String, CodingKey {
        case page
        case pages
        case perpage
        case total
        case result = "photo"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let stringTotal = try container.decode(String.self, forKey: .total)
        guard let intTotal = Int(stringTotal) else {
            throw Error.unexpectedTotalValue
        }

        total = intTotal
        page = try container.decode(Int.self, forKey: .page)
        pages = try container.decode(Int.self, forKey: .pages)
        perpage = try container.decode(Int.self, forKey: .perpage)
        result = try container.decode([T].self, forKey: .result)
    }
}
