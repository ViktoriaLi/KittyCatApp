//
//  BreedModel.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

struct BreedModel: Codable, Identifiable, Hashable {
    
    var id: String
    var name: String
    var temperament: String
    var origin: String
    var description: String?
    var hypoallergenic: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case temperament = "temperament"
        case origin = "origin"
        case description = "description"
        case hypoallergenic = "hypoallergenic"
    }
}
