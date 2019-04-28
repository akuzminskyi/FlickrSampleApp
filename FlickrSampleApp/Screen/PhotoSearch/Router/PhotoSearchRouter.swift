//
//  PhotoSearchRouter.swift
//  FlickrSampleApp
//
//  Created by Andrii Kuzminskyi on 27/04/2019.
//  Copyright © 2019 akuzminskyi. All rights reserved.
//

import UIKit

enum PhotoSearchRouter: PhotoSearchRouterInterface {
    private enum Constant {
        static let storyboardName = "PhotoSearch"
    }

    static func buildModule() throws -> UIViewController {
        let configuration = try NetworkClientConfiguration(from: Bundle.main)
        let networkClient = FlickrNetworkClient(
            networkProvider: URLSession.shared,
            configuration: configuration
        )
        let flickrService = FlickrService(networkClient: networkClient)
        let interactor = PhotoSearchInteractor(flickrService: flickrService)

        let storyboard = UIStoryboard(name: Constant.storyboardName, bundle: .main)
        let view: PhotoSearchViewController = storyboard.instantiateViewController()
        let viewModelBuilder = PhotoSearchViewModelBuilder(photoUrlBuilder: FlickrPhotoURLBuilder())
        let presenter = PhotoSearchPresenter(
            view: view,
            interactor: interactor,
            viewModelBuilder: viewModelBuilder
        )

        interactor.output = presenter
        view.output = presenter

        return view
    }
}
