//
//  BorderedButton.swift
//  CBCApp
//
//  Created by Raphael Kohn on 31/03/17.
//  Copyright © 2017 Raphael Ayres Kohn Bastos da Silva. All rights reserved.
//

import UIKit

@IBDesignable class BorderedButton: UIButton {

    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderWidth = 1
            layer.borderColor = newValue?.cgColor
        }
        get {
            
            return UIColor(cgColor: layer.borderColor!)
        }
    }
    
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }

}
