//
//  DetailInteractor.swift
//  FractalBeerList
//
//  Created by Raphael Kohn on 10/09/17.
//  Copyright © 2017 Raphael Kohn. All rights reserved.
//

import UIKit

class DetailInteractor: NSObject {

    var output: BeerDetailsInteractorOutput!
    var dataManager = BeerDataManager()
}

extension DetailInteractor: BeerDetailsInteractorInput {
    
    func toggleFavorite(_ beer: Beer) {
        
        dataManager.toggleFavorite(beer, completion: { (favorite, error) in
            
            if let f = favorite {
                self.output.addTo(favorites: f, error: nil)
            }
            else {
                self.output.addTo(favorites: false, error: error)
            }
        })
    }
}
