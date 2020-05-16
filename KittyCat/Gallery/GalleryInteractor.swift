//
//  GalleryInteractor.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol GalleryBusinessLogic {
    func getImages(request: GalleryView.GetImages.Request)
}

protocol GalleryViewDataStore {}

final class GalleryViewInteractor: GalleryBusinessLogic, GalleryViewDataStore {
    
    var presenter: GalleryViewPresentationLogic?
    private var networkManager = NetworkManager()
    
    func getImages(request: GalleryView.GetImages.Request) {
        
        networkManager.getImages(completion: { (images, error) in
            if let breedImages = images, breedImages.count > 0 {
                let response = GalleryView.GetImages.Response(imageUrls: breedImages)
                self.presenter?.processingImages(response: response)
            } else if error != nil {
                let response = GalleryView.GetErrorView.Response(error: .apiError)
                self.presenter?.processingError(response: response)
            }
        })
    }
    
}
