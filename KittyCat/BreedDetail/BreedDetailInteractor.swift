//
//  BreedDetailInteractor.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol BreedDetailBusinessLogic {
    func getImageUrl(request: BreedDetailView.GetImage.Request)
}

protocol BreedDetailViewDataStore {}

final class BreedDetailViewInteractor: BreedDetailBusinessLogic, BreedDetailViewDataStore {
    
    var presenter: BreedDetailViewPresentationLogic?
    private var networkManager = NetworkManager()
    
    func getImageUrl(request: BreedDetailView.GetImage.Request) {
        
        networkManager.getBreedImageById(breedId: request.breedId, completion: { (image, error) in
            if let breedImage = image, breedImage.count > 0 {
                let response = BreedDetailView.GetImage.Response(imageUrl: breedImage[0].url)
                self.presenter?.processingImage(response: response)
            } else if error != nil {
                let response = BreedDetailView.GetErrorView.Response(error: .failed)
                self.presenter?.processingError(response: response)
            }
        })
    }
    
}
