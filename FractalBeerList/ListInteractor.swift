//
//  ListInteractor.swift
//  FractalBeerList
//
//  Created by Raphael Kohn on 09/09/17.
//  Copyright © 2017 Raphael Kohn. All rights reserved.
//

import UIKit

class ListInteractor: NSObject {

    var output: BeerListInteractorOutput!
    var dataManager = BeerDataManager()
}

extension ListInteractor: BeerListInteractorInput {
    
    func fetchBeers() {
        
        dataManager.fetchBeersrFromApi({ (beers, error) in
            
            if let b = beers {
                self.output.beersFectched(b)
            }
            else {
                
                self.output.errorFetchingBeers(error: error!)
            }
        })
    }
}
