//
//  ItemInCartCell.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-19.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class ItemInCartCell: UITableViewCell {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNamelabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var qtyTextField: UITextField!
    
    // MARK: Properties
    
    var shoppingCart = ShoppingCart.sharedInstance
    var item: (product: Product, qty: Int)? {
        didSet {
            if let currentItem = item {
                refreshCell(currentItem: currentItem)
            }
        }
    }
    
    var itemIndexPath: IndexPath?
    weak var delegate: ShoppingCartDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        qtyTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Private Functions
    
    private func refreshCell(currentItem: (product: Product, qty: Int)) {
        productImageView.image = Utility.image(withName: currentItem.product.mainImage, andType: "jpg")
        productNamelabel.text = currentItem.product.name
        qtyTextField.text = "\(currentItem.qty)"
        priceLabel.text = currentItem.product.salePrice.currencyFormatter
    }
    
    
    // MARK: IBActions
    
    @IBAction func didTapRemove(_ sender: UIButton) {
        if let product = item?.product, let itemIndexPath = itemIndexPath {
            delegate?.confirmRemoval!(forProduct: product, itemIndexPath: itemIndexPath)
        }
    }
}

// MARK: UITextFieldDelegate

extension ItemInCartCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let qty = qtyTextField.text, let currentItem = self.item {
            shoppingCart.update(product: currentItem.product, qty: Int(qty)!)
            delegate?.updateTotalCartItem()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}













