//
//  FullImagePresenter.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol  FullImageViewPresentationLogic {
    func processingError(response: FullImageView.GetErrorView.Response)
    func processingImage(response: FullImageView.GetImage.Response)
}

final class FullImageViewPresenter: FullImageViewPresentationLogic {
    
    weak var viewController: FullImageViewDisplayLogic?
    
    func processingError(response: FullImageView.GetErrorView.Response) {
        switch response.error {

        case .success:
            break
        default:
            let viewModel = FullImageView.GetErrorView.ViewModel(error: "Something wrong")
        }
    }
    
    func processingImage(response: FullImageView.GetImage.Response) {

        let viewModel = FullImageView.GetImage.ViewModel(url: response.url)
        viewController?.displayImage(viewModel: viewModel)
    }
    
}
