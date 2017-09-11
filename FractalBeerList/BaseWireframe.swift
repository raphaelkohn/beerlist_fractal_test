//
//  BaseWireframe.swift
//  FractalBeerList
//
//  Created by Raphael Kohn on 10/09/17.
//  Copyright © 2017 Raphael Kohn. All rights reserved.
//

import UIKit

class BaseWireframe: NSObject {

    internal var mainStoryBoard: UIStoryboard {
        
        get {
            
            return UIStoryboard(name: "Main", bundle: nil)
        }
    }
}
