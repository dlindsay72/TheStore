//
//  ShoppingCart.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-18.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

@objc protocol ShoppingCartDelegate: class {
    func updateTotalCartItem()
    @objc optional func confirmRemoval(forProduct product: Product, itemIndexPath: IndexPath)
}

class ShoppingCart {
    
    var items = [(product: Product, qty: Int)]()
    var customer: Customer?
    var creditCard: CreditCard?
    var shippingadress: Address?
    
    static let sharedInstance = ShoppingCart()
    private init() {}
    
    internal func add(product: Product, qty: Int) {
        // Check if a product already exists in the shopping cart
        if let index = find(product: product) {
            // if already exist in the shopping cart, add the qty to the current qty
            let newQty = items[index].qty + qty
            
            items[index] = (product, newQty)
        } else {
            // if not already exists in the shopping cart, add the product with the qty to items array
            items.append((product, qty))
        }
    }
    
    internal func update(product: Product, qty: Int) {
        if let index = find(product: product) {
            items[index] = (product, qty)
        }
    }
    
    internal func delete(product: Product) {
        if let index = find(product: product) {
            items.remove(at: index)
        }
    }
    
    internal func totalItem() -> Int {
        var totalItem = 0
        
        for item in items {
            totalItem += item.qty
        }
        
        return totalItem
    }
    
    internal func totalItemCost() -> Double {
        var totalCost: Double = 0.0
        
        for item in items {
            totalCost += Double(item.qty) * item.product.salePrice
        }
        
        return totalCost
    }
    
    internal func assignCart(toCustomer customer: Customer) {
        self.customer = customer
    }
    
    internal func assignShipping(address: Address) {
        self.shippingadress = address
    }
    
    private func find(product: Product) -> Int? {
        let index = items.index(where: { $0.product == product})
        
        return index
    }
}

















