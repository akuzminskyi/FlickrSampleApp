//
//  UICollectionView+Generic.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 28/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(
        for indexPath: IndexPath,
        withIdentifier identifier: String = String(describing: T.self)
    ) -> T {
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}
