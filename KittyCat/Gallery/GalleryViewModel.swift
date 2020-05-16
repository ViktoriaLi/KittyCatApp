//
//  GalleryViewModel.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

enum GalleryView {
    
    enum GetImages {
        
        struct Request {
            var ifFirstSearch: Bool
        }
        
        struct Response {
            let imageUrls: [ShortImageModel]
        }
        
        struct ViewModel {
            let imageUrls: [ShortImageModel]
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
