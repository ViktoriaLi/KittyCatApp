//
//  BreedsListPresenter.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol BreedsListViewPresentationLogic {
    func processingError(response: BreedsListView.GetErrorView.Response)
    func processingBreeds(response: BreedsListView.GetBreeds.Response)
}

final class BreedsListViewPresenter: BreedsListViewPresentationLogic {
    
    weak var viewController: BreedsListViewDisplayLogic?
    
    func processingError(response: BreedsListView.GetErrorView.Response) {
        switch response.error {
            
        case ApiResponse.noNetwork:
            let viewModel = BreedsListView.GetErrorView.ViewModel(error: "Network error")
        case .success:
            break
        default:
            let viewModel = BreedsListView.GetErrorView.ViewModel(error: "Something wrong")
        }
    }
    
    func processingBreeds(response: BreedsListView.GetBreeds.Response) {

        let viewModel = BreedsListView.GetBreeds.ViewModel(breeds: response.breeds)
        viewController?.fillBreedsList(viewModel: viewModel)
    }
    
}
