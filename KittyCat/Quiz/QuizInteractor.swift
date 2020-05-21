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

protocol QuizViewDataStore {}

final class QuizViewInteractor: QuizBusinessLogic, QuizViewDataStore {
    
    var presenter: QuizViewPresentationLogic?
    private var networkManager = NetworkManager()
    
    func getBreeds(request: QuizView.GetBreeds.Request) {
        
        networkManager.getBreedsWithInfo(completion: { (breeds, error) in
            if let allBreeds = breeds {
                let response = QuizView.GetBreeds.Response(breeds: allBreeds)
                self.presenter?.processingBreeds(response: response)
            } else if error != nil {
                let response = QuizView.GetErrorView.Response(error: .failed)
                self.presenter?.processingError(response: response)
            }
        })
    }
    
    func getImageUrl(request: QuizView.GetImage.Request) {
        
        networkManager.getBreedImageById(breedId: request.breedId, completion: { (image, error) in
            if let breedImage = image, breedImage.count > 0 {
                let response = QuizView.GetImage.Response(imageUrl: breedImage[0].url)
                self.presenter?.processingImage(response: response)
            } else if error != nil {
                let response = QuizView.GetErrorView.Response(error: .failed)
                self.presenter?.processingError(response: response)
            }
        })
    }
    
}
