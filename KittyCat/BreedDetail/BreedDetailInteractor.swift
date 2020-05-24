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

final class BreedDetailViewInteractor: BreedDetailBusinessLogic {
    
    var presenter: BreedDetailViewPresentationLogic?
    private var networkManager = NetworkManager()
    
    func getImageUrl(request: BreedDetailView.GetImage.Request) {
        
        networkManager.getData(target: .getImageById(id: request.breedId), completion: { (result: Result<[ShortImageModel], ApiResponse>) in
           switch result {
           case .failure:
               let response = BreedDetailView.GetErrorView.Response(error: .failed)
               self.presenter?.processingError(response: response)
           case .success(let breedImage):
               let response = BreedDetailView.GetImage.Response(imageUrl: breedImage[0].url)
               self.presenter?.processingImage(response: response)
           }
        })
    }
    
}
