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
            cell.imageView.downloadImage(from: imageUrl) { result in
                guard collectionView.indexPath(for: cell) == indexPath,
                    case let .success(image) = result else {
                        return
                }

                cell.imageView.image = image
            }
        }
    }
}

extension PhotoSearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        output?.onPrefetchItemAt(indexes: indexPaths.map { $0.row })
    }
}

extension PhotoSearchViewController: PhotoSearchViewInput {
    func showUpdatedViewModels(_ viewModels: [PhotoViewModel], at range: Range<Int>) {
        let updatedIndexPaths = range.map { IndexPath(item: $0, section: 0) }
        self.viewModels?.replaceSubrange(range, with: viewModels)
        collectionView.reloadItems(at: updatedIndexPaths)
    }

    func showSearchResult(for text: String, with viewModels: [PhotoViewModel]) {
        self.viewModels = viewModels
        collectionView.reloadData()
        if viewModels.isEmpty {
            collectionView.contentOffset = .zero
        } else {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        }
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
