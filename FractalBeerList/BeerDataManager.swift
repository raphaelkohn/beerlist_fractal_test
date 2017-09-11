//
//  BeerDataManager.swift
//  FractalBeerList
//
//  Created by Raphael Kohn on 10/09/17.
//  Copyright © 2017 Raphael Kohn. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class BeerDataManager: NSObject {

    let baseUrl = "https://api.punkapi.com/v2/beers"
    
    func fetchBeersrFromApi(_ completion:@escaping ([Beer]?, Error?) -> ()) {
        
        Alamofire.request(baseUrl, method: .get).validate().responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("Beers: \(json)")
                
                let beers = json.arrayValue.map({ (json) -> Beer in
                    
                    return self.entity(from: json)
                })
                
                self.cache(records: beers)
                let completedBeers = self.findFavorites(beers)
                
                completion(completedBeers, nil)
                
            case .failure (let error):
                
                completion(nil, error)
            }
        }
    }
    
    fileprivate func findFavorites(_ beers:[Beer]) -> [Beer]? {
        
        let appDelegate     = UIApplication.shared.delegate as! AppDelegate
        let managedContext  = appDelegate.persistentContainer.viewContext
        
        let fetchRequest        = NSFetchRequest<NSManagedObject>(entityName: "CoreDataBeer")
        let predicate           = NSPredicate(format: "isFavorite == true")
        fetchRequest.predicate  = predicate
        
        do {
            let cachedBeers = try managedContext.fetch(fetchRequest)
            
            let completedBeers = beers.map({ (b) -> Beer in
                
                let cb = cachedBeers.filter { $0.value(forKey: "id") as! String == b.id }
                
                return  (cb.count > 0 ? self.entity(from: cb[0]) : b)
            })
            
            return completedBeers
        }
        catch let error as NSError {
            print("Problems fetching. \(error), \(error.userInfo)")
            return beers
        }
    }
    
    func toggleFavorite(_ beer:Beer, completion: @escaping (Bool?, Error?) -> ()) {
        
        let appDelegate     = UIApplication.shared.delegate as! AppDelegate
        let managedContext  = appDelegate.persistentContainer.viewContext
        
        let fetchRequest        = NSFetchRequest<NSManagedObject>(entityName: "CoreDataBeer")
        let predicate           = NSPredicate(format: "id == %@", beer.id)
        fetchRequest.predicate  = predicate
        
        do {
            let cachedBeer = try managedContext.fetch(fetchRequest)[0]
            let favorite   = cachedBeer.value(forKey: "isFavorite") as! Bool
            cachedBeer.setValue(!favorite, forKey: "isFavorite")
            try managedContext.save()
            
            completion(!favorite, nil)
        }
        catch let error as NSError {
            print("Problems fetching. \(error), \(error.userInfo)")
            completion(nil, error)
        }

    }
    
    fileprivate func entity(from json:JSON) -> Beer {
        
        let beerName        = json["name"].stringValue
        let beerTagline     = json["tagline"].stringValue
        let beerImageUrl    = json["image_url"].stringValue
        let beerDescription = json["description"].stringValue
        let beerId          = json["id"].stringValue
        
        let newBeer = Beer(id: beerId, imageUrl: beerImageUrl, tagline: beerTagline, name: beerName, description: beerDescription)
        
        return newBeer
    }
    
    fileprivate func entity(from managedObject: NSManagedObject) -> Beer {
        
        let beerName        = managedObject.value(forKey: "name") as! String
        let beerTagline     = managedObject.value(forKey: "tagline") as! String
        let beerImageUrl    = managedObject.value(forKey: "imageUrl") as! String
        let beerDescription = managedObject.value(forKey: "desc") as! String
        let beerId          = managedObject.value(forKey: "id") as! String
        let beerisFavorite  = managedObject.value(forKey: "isFavorite") as! Bool
        
        var newBeer         = Beer(id: beerId, imageUrl: beerImageUrl, tagline: beerTagline, name: beerName, description: beerDescription)
        newBeer.isFavorite  = beerisFavorite
        
        return newBeer
    }
    
    fileprivate func cache(records beers:[Beer]) {
        
        let appDelegate     = UIApplication.shared.delegate as! AppDelegate
        let managedContext  = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CoreDataBeer")
        var beersToCache:[Beer] = []
        
        do {
            let cachedBeers = try managedContext.fetch(fetchRequest)
            
            if cachedBeers.count == 0 {
                
                beersToCache = beers
            }
            else {
            
                let unCachedBeer = cachedBeers.filter({ (cached) -> Bool in
                    
                    return beers.filter{$0.id == cached.value(forKey: "id") as! String}.count == 0
                })
                
                beersToCache = unCachedBeer.map({ (cached) -> Beer in
                    
                    return entity(from: cached)
                })
            }
            
        } catch let error as NSError {
            print("Problems fetching. \(error), \(error.userInfo)")
        }
        
        if beersToCache.count == 0 {
            
            return
        }
        
        for beer in beersToCache {
            
            let entity      = NSEntityDescription.entity(forEntityName: "CoreDataBeer", in: managedContext)!
            let newBeer     = NSManagedObject(entity: entity, insertInto: managedContext)
            
            newBeer.setValue(beer.name, forKeyPath: "name")
            newBeer.setValue(beer.taglineRaw, forKey: "tagline")
            newBeer.setValue(beer.id, forKey: "id")
            newBeer.setValue(beer.imageUrl, forKey: "imageUrl")
            newBeer.setValue(beer.description, forKey: "desc")
            newBeer.setValue(false, forKey: "isFavorite")
        }
        
        do {
            try managedContext.save()
            
        }
        catch let error as NSError {
            print("Problems saving. \(error), \(error.userInfo)")
        }
    }
}
