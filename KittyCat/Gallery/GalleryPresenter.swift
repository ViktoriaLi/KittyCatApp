//
//  GalleryPresenter.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol GalleryViewPresentationLogic {
    func processingError(response: GalleryView.GetErrorView.Response)
    func processingImages(response: GalleryView.GetImages.Response)
}

final class GalleryViewPresenter: GalleryViewPresentationLogic {
    
    weak var viewController: GalleryViewDisplayLogic?
    
    func processingError(response: GalleryView.GetErrorView.Response) {
        switch response.error {
        case .success:
            break
        default:
            let viewModel = GalleryView.GetErrorView.ViewModel()
            viewController?.showErrorView(viewModel: viewModel)
        }
    }
    
    func processingImages(response: GalleryView.GetImages.Response) {

        let viewModel = GalleryView.GetImages.ViewModel(imageUrls: response.imageUrls)
        viewController?.displayImages(viewModel: viewModel)
    }
    
}
