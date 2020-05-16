//
//  ShortBreedModel.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

struct ShortBreedModel: Codable, Identifiable, Hashable {
        
    var id: String
    var name: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
