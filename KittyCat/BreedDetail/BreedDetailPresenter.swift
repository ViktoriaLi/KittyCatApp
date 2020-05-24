//
//  BreedDetailPresenter.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol BreedDetailViewPresentationLogic {
    func processingError(response: BreedDetailView.GetErrorView.Response)
    func processingImage(response: BreedDetailView.GetImage.Response)
}

final class BreedDetailViewPresenter: BreedDetailViewPresentationLogic {
    
    weak var viewController: BreedDetailViewDisplayLogic?
    
    func processingError(response: BreedDetailView.GetErrorView.Response) {
        switch response.error {
            
        case .success:
            break
        default:
            let viewModel = BreedDetailView.GetErrorView.ViewModel()
            viewController?.displayDefaultImage(viewModel: viewModel)
        }
    }
    
    func processingImage(response: BreedDetailView.GetImage.Response) {

        let viewModel = BreedDetailView.GetImage.ViewModel(imageUrl: response.imageUrl)
        viewController?.displayImage(viewModel: viewModel)
    }
    
}
