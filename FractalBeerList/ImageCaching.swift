//
//  ImageCaching.swift
//  FractalBeerList
//
//  Created by Raphael Kohn on 10/09/17.
//  Copyright © 2017 Raphael Kohn. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ImageCaching: NSObject {

    open class func retrieveImageAndCacheIfNeeded(_ remoteImagePath: String, identifier:String, completion: @escaping (UIImage?) -> ()) {
        
        let imageCache = AutoPurgingImageCache()
        
        let image = imageCache.image(withIdentifier: identifier)
        
        if image != nil {
        
            completion(image)
        }
        else {
            Alamofire.request(remoteImagePath).responseImage { response in
                
                if let image = response.result.value {
                    
                    imageCache.add(image, withIdentifier: identifier)
                    completion(image)
                }
            }
        }
    }
}
