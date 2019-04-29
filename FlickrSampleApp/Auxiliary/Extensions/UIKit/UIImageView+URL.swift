//
//  UIImageView+URL.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 29/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

extension UIImageView {
    enum Error: Swift.Error, LocalizedError {
        case invalidImageData

        var errorDescription: String? {
            switch self {
            case .invalidImageData:
                return "Error_ImageDownloader_InvalidImageData".localized()
            }
        }
    }

    func downloadImage(
        from url: URL,
        using cache: NSCache<NSURL, UIImage>? = .sharedImageCache,
        completionHandler: @escaping (Result<UIImage, Swift.Error>) -> Void
    ) {
        let mainThreadCompletionHandler: (Result<UIImage, Swift.Error>) -> Void = { value in
            DispatchQueue.main.async {
                completionHandler(value)
            }
        }

        if let image = cache?.object(forKey: url as NSURL) {
            mainThreadCompletionHandler(.success(image))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                mainThreadCompletionHandler(.failure(error))
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                mainThreadCompletionHandler(.failure(Error.invalidImageData))
                return
            }

            cache?.setObject(image, forKey: url as NSURL)
            mainThreadCompletionHandler(.success(image))
        }.resume()
    }
}
