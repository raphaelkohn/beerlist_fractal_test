//
//  DetailPresenter.swift
//  FractalBeerList
//
//  Created by Raphael Kohn on 10/09/17.
//  Copyright © 2017 Raphael Kohn. All rights reserved.
//

import UIKit

class DetailPresenter: NSObject {

    var detailWireframe: BeerDetailsWireframeInterface!
    weak var detailViewUserInterface: BeerDetailsViewInterface!
    var detailsInteractorInput: BeerDetailsInteractorInput!

}

extension DetailPresenter: BeerDetailsModuleInterface {
    
    func toggleFavorite(_ beer: Beer) {
        
        detailsInteractorInput.toggleFavorite(beer)
    }
}

extension DetailPresenter: BeerDetailsInteractorOutput {
    
    func addTo(favorites result:Bool, error: Error?) {
        
        if let e = error {
            
            detailViewUserInterface.showError(e)
        }
        else {
            
            detailViewUserInterface.markFavorite(result)
        }
    }
}
