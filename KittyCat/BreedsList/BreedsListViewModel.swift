//
//  BreedsListViewModel.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

enum BreedsListView {
    
    enum GetBreeds {
        
        struct Request {
        }
        
        struct Response {
            let breeds: [ShortBreedModel]
        }
        
        struct ViewModel {
            let breeds: [ShortBreedModel]
        }
    }
    
    enum GetErrorView {
        struct Request {
            
        }
        
        struct Response {
            let error: ApiResponse
        }
        
        struct ViewModel {
            let error: String
        }
    }
}
