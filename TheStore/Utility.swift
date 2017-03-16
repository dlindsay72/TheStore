//
//  Utility.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-16.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class Utility {
    
    class func image(withName name: String?, andType type: String) -> UIImage {
        let imagePath = Bundle.main.path(forResource: name?.stripFileExtension(), ofType: type)
        
        var image: UIImage?
        if let path = imagePath {
            image = UIImage(contentsOfFile: path)
        }
        
        return image!
    }
}
