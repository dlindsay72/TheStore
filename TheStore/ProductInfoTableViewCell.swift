//
//  ProductInfoTableViewCell.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-18.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class ProductInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var productSpecLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
