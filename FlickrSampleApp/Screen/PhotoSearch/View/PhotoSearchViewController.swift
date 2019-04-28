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
        return UICollectionViewCell(frame: .zero)
    }
}

extension PhotoSearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

    }
}

extension PhotoSearchViewController: PhotoSearchViewInput {
    func showSearchResult(for text: String, with viewModels: [PhotoViewModel]) {
        searchBar.text = text
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
