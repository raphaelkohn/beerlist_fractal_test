//
//  BeerTableViewCell.swift
//  FractalBeerList
//
//  Created by Raphael Kohn on 10/09/17.
//  Copyright © 2017 Raphael Kohn. All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var tagline: UICollectionView!
    @IBOutlet weak var imageLoading: UIActivityIndicatorView!
    @IBOutlet weak var beerFavorite: UIImageView!
    
    var tagsArr: [String] = [] {
        didSet {
            self.tagline.reloadData()
        }
    }
    
    fileprivate let labelTag = 1000

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageLoading.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func toggleFavorite(_ favorite:Bool) {
        
        if favorite {
            
            let image        = UIImage(named: "star_on")
            
            self.beerFavorite.image = image
        }
        else {
            
            self.beerFavorite.image = nil
        }
    }
}

extension BeerTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate func size(for tag:String) -> CGSize {
        
        let nsTag = tag as NSString
        let size: CGSize = nsTag.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12.0)])
        
        return CGSize(width: size.width + 10, height: 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tag = tagsArr[indexPath.row]
        
        return size(for: tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Here we could implement some sort of search from tags
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell        = collectionView.dequeueReusableCell(withReuseIdentifier: "tag", for: indexPath)
        let tagLabel    = cell.viewWithTag(labelTag) as! UIButton
        let tag = tagsArr[indexPath.row]
        tagLabel.setTitle(tag, for: .normal)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

