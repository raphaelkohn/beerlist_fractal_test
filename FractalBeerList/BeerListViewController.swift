//
//  BeerListViewController.swift
//  FractalBeerList
//
//  Created by Raphael Kohn on 09/09/17.
//  Copyright © 2017 Raphael Kohn. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var beers:[Beer] = []
    
    var presenter: BeerListModuleInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.updateItensIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        presenter.updateItensIfNeeded()
    }
}

//VIPER
extension BeerListViewController: BeerListViewInterface {
    
    func showNoContentList() {
        
        self.beers.removeAll()
        self.tableView.reloadData()
    }
    
    func fill(beerList beers: [Beer]) {
        
        self.beers = beers
        self.tableView.reloadData()
    }
    
    func showError(error: Error) {
        
        let alert       = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction    = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.presenter.show(detailsFor: beers[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell") as! BeerTableViewCell
        
        let beer = beers[indexPath.row]
        
        cell.beerName.text = beer.name
        cell.tagsArr       = beer.tagline
        
        cell.toggleFavorite(beer.isFavorite)
        
        cell.beerImageView.image = nil
        cell.imageLoading.startAnimating()
        
        ImageCaching.retrieveImageAndCacheIfNeeded(beer.imageUrl, identifier: beer.id) { (image) in
            
            cell.beerImageView.image = image
            cell.imageLoading.stopAnimating()
        }
        
        return cell
    }
}
