//
//  UserRating.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-17.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class UserRating: UIView {
    
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "yellowstar")
        let emptyStarImage = UIImage(named: "blackstar")
        
        for _ in 0..<5 {
            let button = UIButton()
            button.setImage(emptyStarImage, for: .normal)
            button.setImage(filledStarImage, for: .selected)
            button.adjustsImageWhenHighlighted = false
            
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        // Set the button's width and height
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        var x = 0
        for button in ratingButtons {
            buttonFrame.origin.x = CGFloat(x * (buttonSize + 5))
            button.frame = buttonFrame
            x += 1
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        var x = 0
        
        for button in ratingButtons {
            button.isSelected = x < rating
            x += 1
        }
    }

}
