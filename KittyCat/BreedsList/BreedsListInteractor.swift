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

protocol BreedsListViewDataStore {}

final class BreedsListViewInteractor: BreedsListBusinessLogic, BreedsListViewDataStore {
    
    var presenter: BreedsListViewPresentationLogic?
    private var networkManager = NetworkManager()
    
    func getBreeds(request: BreedsListView.GetBreeds.Request) {
        
        networkManager.getBreedsWithInfo(completion: { (breeds, error) in
            if let allBreeds = breeds {
                let response = BreedsListView.GetBreeds.Response(breeds: allBreeds)
                self.presenter?.processingBreeds(response: response)
            } else if error != nil {
                let response = BreedsListView.GetErrorView.Response(error: .apiError)
                self.presenter?.processingError(response: response)
            }
        })
    }
    
}
