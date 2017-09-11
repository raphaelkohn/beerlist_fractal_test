//
//  Beer.swift
//  FractalBeerList
//
//  Created by Raphael Kohn on 09/09/17.
//  Copyright © 2017 Raphael Kohn. All rights reserved.
//

import Foundation

struct Beer {
    
    var id: String
    var imageUrl: String
    var tagline: [String]
    var name: String
    var description: String
    var isFavorite: Bool = false
    
    var taglineRaw: String
    
    init(id: String, imageUrl: String, tagline: String, name: String, description: String) {
        
        self.id          = id
        self.imageUrl    = imageUrl
        self.tagline     = tagline.components(separatedBy: ". ")
        self.name        = name
        self.description = description
        self.taglineRaw  = tagline
    }
}
