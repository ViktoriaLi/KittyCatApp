//
//  FullImageInteractor.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol FullImageBusinessLogic {
    func getImage(request: FullImageView.GetImage.Request)
}

final class FullImageViewInteractor: FullImageBusinessLogic {
    
    var presenter: FullImageViewPresentationLogiс?
    private var networkManager = NetworkManager()
    
    func getImage(request: FullImageView.GetImage.Request) {
    }
}
