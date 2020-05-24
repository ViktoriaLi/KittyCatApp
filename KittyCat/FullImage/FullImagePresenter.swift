//
//  FullImagePresenter.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol FullImageViewPresentationLogiс {
    func processingError(response: FullImageView.GetErrorView.Response)
    func processingImage(response: FullImageView.GetImage.Response)
}

final class FullImageViewPresenter: FullImageViewPresentationLogiс {
    
    weak var viewController: FullImageViewDisplayLogic?
    
    func processingError(response: FullImageView.GetErrorView.Response) {
    }
    
    func processingImage(response: FullImageView.GetImage.Response) {
    }
    
}
