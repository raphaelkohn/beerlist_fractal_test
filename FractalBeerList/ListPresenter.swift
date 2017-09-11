//
//  ListPresenter.swift
//  FractalBeerList
//
//  Created by Raphael Kohn on 09/09/17.
//  Copyright © 2017 Raphael Kohn. All rights reserved.
//

import UIKit

class ListPresenter: NSObject {
    
    var listWireframe: BeerListWireframeInterface!
    weak var listViewUserInterface: BeerListViewInterface!
    var listInteractor: BeerListInteractorInput!

}

//VIPER
extension ListPresenter: BeerListModuleInterface {
    
    func updateItensIfNeeded() {
        
        listInteractor.fetchBeers()
    }
    
    func show(detailsFor beer: Beer) {
        
        listWireframe.present(detailsFor: beer)
    }
}

extension ListPresenter: BeerListInteractorOutput {
    
    func beersFectched(_ beers: [Beer]) {
        
        listViewUserInterface.fill(beerList: beers)
    }
    
    func errorFetchingBeers(error: Error) {
        
        listViewUserInterface.showError(error: error)
    }
}
