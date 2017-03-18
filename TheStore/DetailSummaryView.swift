//
//  DetailSummaryView.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-17.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class DetailSummaryView: UIView {
    
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var listPriceLabel: UILabel!
    @IBOutlet weak var dealPriceLabel: UILabel!
    @IBOutlet weak var priceSavedDollarLabel: UILabel!
    @IBOutlet weak var priceSavedPercentLabel: UILabel!
    @IBOutlet weak var inStockLabel: UILabel!
    @IBOutlet weak var qtyLeftLabel: UILabel!
    @IBOutlet weak var quantityButton: UIButton!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var userRating: UserRating!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func updateView(with product: Product) {
        
        //Set default state
        qtyLeftLabel.isHidden = true
        quantityButton.setTitle("Quantity: 1", for: .normal)
        quantityButton.isEnabled = true
        quantityButton.alpha = 1.0
        addToCartButton.isEnabled = true
        addToCartButton.alpha = 1.0
        
        // Product Info
        manufacturerLabel.text = product.manufacturer?.name
//        if let name = product.name {
//            print("Product name: \(name)")
//        }
        productNameLabel.text = product.name
        userRating.rating = Int(product.rating)
        
        let listPriceAttributedString = NSAttributedString(string: product.regularPrice.currencyFormatter, attributes: [NSStrikethroughStyleAttributeName: 1])
        listPriceLabel.attributedText = listPriceAttributedString
        
        dealPriceLabel.text = product.salePrice.currencyFormatter
        priceSavedDollarLabel.text = (product.regularPrice - product.salePrice).currencyFormatter
        
        let percentSaved = ((product.regularPrice - product.salePrice) / product.regularPrice).percentFormatter
        priceSavedPercentLabel.text = percentSaved
        
        if product.quantity > 0 {
            inStockLabel.textColor = UIColor().store_green()
            inStockLabel.text = "In Stock!"
            
            if product.quantity < 5 {
                qtyLeftLabel.isHidden = false
                let qtyLeftStr = product.quantity == 1 ? "item" : "items"
                qtyLeftLabel.text = "Only \(product.quantity) \(qtyLeftStr) left"
            }
        } else {
            inStockLabel.textColor = UIColor.red
            inStockLabel.text = "Currently Unavailable"
            
            quantityButton.setTitle("Quantity: 0", for: .normal)
            quantityButton.isEnabled = false
            quantityButton.alpha = 0.5
            
            addToCartButton.isEnabled = false
            addToCartButton.alpha = 0.5
            
        }
        
        if let images = product.productImages {
            let allImages = images.allObjects as! [ProductImage]
            
            if let mainImage = allImages.first {
                productImageView.image = Utility.image(withName: mainImage.name, andType: "jpg")
            }
        }
        
        
        
    }

}
