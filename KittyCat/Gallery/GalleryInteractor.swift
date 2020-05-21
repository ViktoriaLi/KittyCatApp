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
    private var cursor = 0
    private let limit = 20
    
    func getImages(request: GalleryView.GetImages.Request) {
        if request.ifFirstSearch == true {
            cursor = 0
        }
        if request.ifFirstSearch == true || cursor != 0 {
            networkManager.getImages(limit: limit, cursor: cursor, completion: { (images, error) in
                if let breedImages = images, breedImages.count > 0 {
                    if breedImages.count == 0 {
                        self.cursor = 0
                    } else {
                        self.cursor += 1
                    }
                    let response = GalleryView.GetImages.Response(imageUrls: breedImages)
                    self.presenter?.processingImages(response: response)
                } else if error != nil {
                    self.cursor = 0
                    let response = GalleryView.GetErrorView.Response(error: .failed)
                    self.presenter?.processingError(response: response)
                }
            })
        }
    }
}
