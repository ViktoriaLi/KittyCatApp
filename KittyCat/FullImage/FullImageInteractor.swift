//
//  FullImageInteractor.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol FullImageBusinessLogic {
    func getImage(request: FullImageView.GetImage.Request)
}

protocol FullImageViewDataStore {}

final class FullImageViewInteractor: FullImageBusinessLogic, FullImageViewDataStore {
    
    var presenter: FullImageViewPresentationLogic?
    private var networkManager = NetworkManager()
    
    func getImage(request: FullImageView.GetImage.Request) {
        
        networkManager.getFullImageById(imageId: request.id, completion: { (image, error) in
            if let breedImage = image {
                let response = FullImageView.GetImage.Response(url: breedImage.url)
                self.presenter?.processingImage(response: response)
            } else if error != nil {
                let response = FullImageView.GetErrorView.Response(error: .failed)
                self.presenter?.processingError(response: response)
            }
        })
    }
    
}
