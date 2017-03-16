//
//  String+Extension.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-16.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

extension String {
    func stripFileExtension() -> String {
        if self.contains(".") {
            // .jpg, .png
            return self.substring(to: self.characters.index(of: ".")!)
        }
        return self
    }
}

