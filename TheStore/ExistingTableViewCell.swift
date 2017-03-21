//
//  ExistingTableViewCell.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-21.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class ExistingTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var cardTypeImageView: UIImageView!
    @IBOutlet weak var carNumberLabel: UILabel!
    @IBOutlet weak var nameOnCardLabel: UILabel!
    @IBOutlet weak var expirationLabel: UILabel!
    @IBOutlet weak var noCreditCardLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func configureCell(withCreditCard creditCard: CreditCard) {
        noCreditCardLabel.isHidden = true
        
        carNumberLabel.text = creditCard.cardNumber?.maskedPlusLast4()
        cardTypeImageView.image = UIImage(named: creditCard.type!)
        nameOnCardLabel.text = creditCard.nameOnCard
        expirationLabel.text = "\(creditCard.expMonth)/\(creditCard.expYear)"
        
        
    }

}
