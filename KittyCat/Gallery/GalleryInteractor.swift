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

final class GalleryViewInteractor: GalleryBusinessLogic {
    
    var presenter: GalleryViewPresentationLogic?
    private var networkManager = NetworkManager()
    private var cursor = 0
    private let limit = 20
    
    func getImages(request: GalleryView.GetImages.Request) {
        if request.ifFirstSearch == true {
            cursor = 0
        }
        networkManager.getData(target: .getImages(limit: limit, cursor: cursor), completion: { (result: Result<[ShortImageModel], ApiResponse>) in
            switch result {
            case .failure:
                self.cursor = 0
                let response = GalleryView.GetErrorView.Response(error: .failed)
                self.presenter?.processingError(response: response)
            case .success(let breedImages):
                if breedImages.count == 0 {
                    self.cursor = 0
                } else {
                    self.cursor += 1
                }
                let response = GalleryView.GetImages.Response(imageUrls: breedImages)
                self.presenter?.processingImages(response: response)
            }
        })
    }
}
