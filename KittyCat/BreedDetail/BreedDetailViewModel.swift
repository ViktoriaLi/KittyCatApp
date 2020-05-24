//
//  BreedDetailViewModel.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

enum BreedDetailView {
    
    enum GetImage {
        
        struct Request {
            var breedId: String
        }
        
        struct Response {
            let imageUrl: String
        }
        
        struct ViewModel {
            let imageUrl: String
        }
    }
    
    enum GetErrorView {
        struct Request {
        }
        
        struct Response {
            let error: ApiResponse
        }
        
        struct ViewModel {
        }
    }
}
