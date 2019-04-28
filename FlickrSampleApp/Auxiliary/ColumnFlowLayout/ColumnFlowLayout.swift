//
//  ColumnFlowLayout.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 28/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

final class ColumnFlowLayout: UICollectionViewFlowLayout {
    @IBInspectable var numerOfColumn: Int = 1
    @IBInspectable var sizeRatio: CGFloat = 1

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView, numerOfColumn > 0 else {
            return
        }
        let availableBounds = collectionView.bounds
            .inset(by: collectionView.layoutMargins)
            .inset(by: sectionInset)
        let availableWidth = availableBounds.width - minimumInteritemSpacing * CGFloat(numerOfColumn - 1)
        let itemWith = (availableWidth / CGFloat(numerOfColumn)).rounded(.down)

        itemSize = CGSize(width: itemWith, height: itemWith * 1.0 / (sizeRatio))
    }
}
