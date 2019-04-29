//
//  UIImageView+URL.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 29/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

extension UIImageView {
    // TODO: Add NSCache
    enum Error: Swift.Error {
        case invalidImageData
    }

    func downloadImage(
        from url: URL,
        completionHandler: @escaping (Result<UIImage, Swift.Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            let mainThreadCompletionHandler: (Result<UIImage, Swift.Error>) -> Void = { value in
                DispatchQueue.main.async {
                    completionHandler(value)
                }
            }

            if let error = error {
                mainThreadCompletionHandler(.failure(error))
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                mainThreadCompletionHandler(.failure(Error.invalidImageData))
                return
            }

            mainThreadCompletionHandler(.success(image))
        }.resume()
    }
}
