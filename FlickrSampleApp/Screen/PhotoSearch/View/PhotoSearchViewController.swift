//
//  PhotoSearchViewController.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

final class PhotoSearchViewController: UIViewController {
    var output: PhotoSearchViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.onViewDidLoad()
    }
}

extension PhotoSearchViewController: PhotoSearchViewInput {
}

}
