//
//  PhotoSearchViewController.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

final class PhotoSearchViewController: UIViewController {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!
    private var viewModels: [PhotoViewModel]?

    var output: PhotoSearchViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.onViewDidLoad()
    }
}

extension PhotoSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoSearchCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
}
extension PhotoSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PhotoSearchCell else {
            return
        }
        if let imageUrl = viewModels?[indexPath.item].imageUrl {
            cell.imageView.downloaded(from: imageUrl)
        }
    }
}

extension PhotoSearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        output?.onPrefetchItemAt(indexes: indexPaths.map { $0.row })
    }
}

extension PhotoSearchViewController: PhotoSearchViewInput {
    func showSearchResult(for text: String, with viewModels: [PhotoViewModel]) {
        self.viewModels = viewModels
        collectionView.reloadData()
    }

    func setSearchBarPlaceholder(_ text: String?) {
        searchBar.placeholder = text
    }

    func showSearchingIndicator(_ isSearching: Bool) {
        if isSearching {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        collectionView.isUserInteractionEnabled = !isSearching
    }
}

extension PhotoSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output?.searchTextDidChange(searchText)
    }
}

private extension UIImageView {
    // TODO: sample code, remove it
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
}
