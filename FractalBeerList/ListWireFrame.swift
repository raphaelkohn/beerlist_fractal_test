//
//  ListWireFrame.swift
//  FractalBeerList
//
//  Created by Raphael Kohn on 09/09/17.
//  Copyright © 2017 Raphael Kohn. All rights reserved.
//

import UIKit

class ListWireFrame: BaseWireframe {

    weak var beerListViewController: UIViewController!
}

//VIPER
extension ListWireFrame: BeerListWireframeInterface {
    
    func present(detailsFor beer: Beer) {
        
        let beerDetailsViewController  = mainStoryBoard.instantiateViewController(withIdentifier: "beerDetails") as! BeerDetailsViewController
        beerDetailsViewController.beer = beer
        
        //Setup Details Module
        let detailsPresenter = DetailPresenter()
        detailsPresenter.detailViewUserInterface = beerDetailsViewController
        beerDetailsViewController.presenter     = detailsPresenter
        
        let detailsWireframe = DetailWireFrame()
        detailsPresenter.detailWireframe = detailsWireframe
        detailsWireframe.beerDetailViewController = beerDetailsViewController
        
        let detailsInteractor = DetailInteractor()
        detailsInteractor.output = detailsPresenter
        detailsPresenter.detailsInteractorInput = detailsInteractor
        
        
        beerListViewController.navigationController?.pushViewController(beerDetailsViewController, animated: true)
    }
}
