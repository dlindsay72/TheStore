//
//  PaymentTableViewCell.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-22.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {
    
    
    //MARK: IBOutlets
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var nameOnCardLabel: UILabel!
    @IBOutlet weak var expirationLabel: UILabel!
    
    //MARK: Properties
    
    let shoppingCart = ShoppingCart.sharedInstance

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func configureCell() {
        if let creditCard = shoppingCart.creditCard {
            let cardType = creditCard.type
            
            cardImageView.image = UIImage(named: cardType!)
            cardNumberLabel.text = creditCard.cardNumber?.maskedPlusLast4()
            nameOnCardLabel.text = creditCard.nameOnCard
            expirationLabel.text = "\(creditCard.expYear)/\(creditCard.expYear)"
        }
    }

}
