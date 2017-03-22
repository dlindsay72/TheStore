//
//  ReviewOrderTableVC.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-22.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

private let placeOrderCellIdentifier = "placeOrderCell"
private let cellItemInCartIdentifier = "cellItemInCart"
private let cellOrderTotalIdentifier = "cellOrderTotal"
private let cellShippingIdentifier = "cellShipping"
private let cellPaymentIdentifier = "cellPayment"
//private let cellItemInCartXibIdentifier = "cellItemInCart"



class ReviewOrderTableVC: UITableViewController {
    
    //MARK: Properties
    var shoppingCart = ShoppingCart.sharedInstance
    weak var reviewDelegate: ShoppingCartDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ItemInCartCell", bundle: nil), forCellReuseIdentifier: "blah") //might be the cellItemIdentifier and not the XibIdentifier
        tableView.tableFooterView = UIView()
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0, 2, 3, 4, 5:
            return 1
        case 1:
            return shoppingCart.items.count
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0, 5:
            tableView.rowHeight = 60
            
            let cell = tableView.dequeueReusableCell(withIdentifier: placeOrderCellIdentifier, for: indexPath)
            return cell
            
        case 1:
            tableView.rowHeight = 80
            
            let item = shoppingCart.items[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "blah", for: indexPath) as! ItemInCartCell
            cell.item = item
            cell.itemIndexPath = indexPath
            cell.delegate = self
            
            return cell
            
        case 2:
            tableView.rowHeight = 60
            
            let itemStr = shoppingCart.items.count == 1 ? "item" : "items"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellOrderTotalIdentifier, for: indexPath)
            cell.textLabel?.text = "Subtotal: \(shoppingCart.totalItem()) \(itemStr))"
            cell.detailTextLabel?.text = shoppingCart.totalItemCost().currencyFormatter
            
            return cell
            
        case 3:
            tableView.rowHeight = 135
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellShippingIdentifier, for: indexPath) as! ShippingTableViewCell
            cell.configureCell()
            
            return cell
            
        case 4:
            tableView.rowHeight = 70
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellPaymentIdentifier, for: indexPath) as! PaymentTableViewCell
            cell.configureCell()
            
            return cell
            
        default:
            return UITableViewCell()
        }

        
    }
}

extension ReviewOrderTableVC: ShoppingCartDelegate {
    func updateTotalCartItem() {
        // invoke delegate in ProductDetailVC to update the number of items in cart
        reviewDelegate?.updateTotalCartItem()
       
        
        tableView.reloadData()
    }
    
    func confirmRemoval(forProduct product: Product, itemIndexPath: IndexPath) {
        let alertController = UIAlertController(title: "Remove Item", message: "Remove \(product.name!.uppercased()) from your shopping cart?", preferredStyle: .actionSheet)
        
        let removeAction = UIAlertAction(title: "Remove", style: .destructive) { [weak self] (action: UIAlertAction) in
            self?.shoppingCart.delete(product: product)
            self?.tableView.deleteRows(at: [itemIndexPath], with: .fade)
            self?.tableView.reloadData()
            
            self?.updateTotalCartItem()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}













