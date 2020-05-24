//
//  FullImageViewModel.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

enum  FullImageView {
    
    enum GetImage {
        
        struct Request {
            var id: String
        }
        
        struct Response {
            let url: String
        }
        
        struct ViewModel {
            let url: String
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
