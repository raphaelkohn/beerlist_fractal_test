//
//  BeerListInterface.swift
//  FractalBeerList
//
//  Created by Raphael Kohn on 09/09/17.
//  Copyright © 2017 Raphael Kohn. All rights reserved.
//

import Foundation

protocol BeerListInteractorOutput: class {
    
    func beersFectched(_ beers:[Beer])
    func errorFetchingBeers(error:Error)
}

protocol BeerListInteractorInput: class {
    
    var output: BeerListInteractorOutput! { get set }
    
    func fetchBeers()
}

protocol BeerListViewInterface: class {
    
    func fill(beerList beers: [Beer])
    func showNoContentList()
    func showError(error: Error)
}

protocol BeerListModuleInterface: class {
    
    weak var listViewUserInterface: BeerListViewInterface! { get set }
    
    func updateItensIfNeeded()
    func show(detailsFor beer:Beer)
}

protocol BeerListWireframeInterface: class {
    
    func present(detailsFor beer:Beer)
}
