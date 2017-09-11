//
//  BeerDetailsViewController.swift
//  FractalBeerList
//
//  Created by Raphael Kohn on 10/09/17.
//  Copyright © 2017 Raphael Kohn. All rights reserved.
//

import UIKit

class BeerDetailsViewController: UIViewController {
    
    var beer: Beer!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var tagline: UICollectionView!
    
    @IBOutlet weak var favoriteButton:UIButton!
    
    var presenter: BeerDetailsModuleInterface!
    
    fileprivate let labelTag = 1000

    override func viewDidLoad() {
        super.viewDidLoad()

        //self.name.text              = beer.name
        self.navigationItem.title   = beer.name
        self.descriptionText.text   = beer.description
        self.tagline.reloadData()
        self.toggleFavorite(beer.isFavorite)
        //Load Image
        ImageCaching.retrieveImageAndCacheIfNeeded(beer.imageUrl, identifier: beer.id) { (image) in
            
            self.imageView.image = image
        }
        
        // Do any additional setup after loading the view.
    }
    
    fileprivate func toggleFavorite(_ favorite:Bool) {
        
        let btnImageName = favorite ? "star_on" : "star_off"
        let image        = UIImage(named: btnImageName)
        
        self.favoriteButton.setImage(image, for: .normal)
    }
    
    @IBAction func toggleFavorite(_ sender: UIButton) {
        
        self.presenter.toggleFavorite(beer)
    }
}

//VIPER
extension BeerDetailsViewController: BeerDetailsViewInterface {
    
    func markFavorite(_ favorite: Bool) {
        
        self.toggleFavorite(favorite)
    }
    
    func showError(_ error: Error) {
        
        let alert       = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction    = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension BeerDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tag = beer.tagline[indexPath.row] as NSString

        let size: CGSize = tag.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12.0)])
        
        return CGSize(width: size.width + 10, height: 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Here we could implement some sort of search from tags
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beer.tagline.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell        = collectionView.dequeueReusableCell(withReuseIdentifier: "tag", for: indexPath)
        let tagLabel    = cell.viewWithTag(labelTag) as! UIButton
        tagLabel.setTitle(beer.tagline[indexPath.row], for: .normal)
        
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
