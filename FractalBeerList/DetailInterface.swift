//
//  DetailInterface.swift
//  FractalBeerList
//
//  Created by Raphael Kohn on 10/09/17.
//  Copyright © 2017 Raphael Kohn. All rights reserved.
//

import Foundation

protocol BeerDetailsInteractorOutput: class {
    
    func addTo(favorites result:Bool, error: Error?)
}

protocol BeerDetailsInteractorInput: class {
    
    var output: BeerDetailsInteractorOutput! { get set }
    
    func toggleFavorite(_ beer: Beer)
}

protocol BeerDetailsViewInterface: class {
    
    func markFavorite(_ favorite:Bool)
    func showError(_ error: Error)
}

protocol BeerDetailsModuleInterface: class {
    
    weak var detailViewUserInterface: BeerDetailsViewInterface! { get set }
    
    func toggleFavorite(_ beer: Beer)
}

protocol BeerDetailsWireframeInterface: class {
    
    
}
