//
//  QuizViewModel.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

enum QuizView {
    
    enum GetBreeds {
        
        struct Request {
        }
        
        struct Response {
            let breeds: [BreedModel]
        }
        
        struct ViewModel {
            let questions: [Question]
        }
    }
    
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
