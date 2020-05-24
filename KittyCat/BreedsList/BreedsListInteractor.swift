//
//  BreedsListInteractor.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol BreedsListBusinessLogic {
    func getBreeds(request: BreedsListView.GetBreeds.Request)
}

final class BreedsListViewInteractor: BreedsListBusinessLogic {
    
    var presenter: BreedsListViewPresentationLogic?
    private var networkManager = NetworkManager()
    
    func getBreeds(request: BreedsListView.GetBreeds.Request) {
        networkManager.getData(target: .getBreeds, completion: { (result: Result<[BreedModel], ApiResponse>) in
            switch result {
            case .failure:
                let response = BreedsListView.GetErrorView.Response(error: .failed)
                self.presenter?.processingError(response: response)
            case .success(let breeds):
                let response = BreedsListView.GetBreeds.Response(breeds: breeds)
                self.presenter?.processingBreeds(response: response)
            }
        })
    }
    
}
