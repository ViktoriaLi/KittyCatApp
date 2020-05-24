//
//  QuizInteractor.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol QuizBusinessLogic {
    func getBreeds(request: QuizView.GetBreeds.Request)
    func getImageUrl(request: QuizView.GetImage.Request)
}

final class QuizViewInteractor: QuizBusinessLogic {
    
    var presenter: QuizViewPresentationLogic?
    private var networkManager = NetworkManager()
    
    func getBreeds(request: QuizView.GetBreeds.Request) {
        
        networkManager.getData(target: .getBreeds, completion: { (result: Result<[BreedModel], ApiResponse>) in
            switch result {
            case .failure:
                let response = QuizView.GetErrorView.Response(error: .failed)
                self.presenter?.processingError(response: response)
            case .success(let breeds):
                let response = QuizView.GetBreeds.Response(breeds: breeds)
                self.presenter?.processingBreeds(response: response)
            }
        })
    }
    
    func getImageUrl(request: QuizView.GetImage.Request) {
        
        networkManager.getData(target: .getImageById(id: request.breedId), completion: { (result: Result<[ShortImageModel], ApiResponse>) in
            switch result {
            case .failure:
                let response = QuizView.GetErrorView.Response(error: .failed)
                self.presenter?.processingError(response: response)
            case .success(let breedImage):
                let response = QuizView.GetImage.Response(imageUrl: breedImage[0].url)
                self.presenter?.processingImage(response: response)
            }
        })
    }
}
