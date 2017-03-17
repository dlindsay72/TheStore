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
        
        if let name = product.name {
            print("Product name: \(name)")
        }
        
    }

}
