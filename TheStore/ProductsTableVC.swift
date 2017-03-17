//
//  ProductsTableVC.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-17.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

private let productCellIdentifier = "productCell"

class ProductsTableVC: UITableViewController {
    
    // MARK: - Properties
    var products: [Product]?
    var selectedProduct: Product?

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.products = ProductService.browse()
        
        if let products = self.products {
            selectedProduct = products.first
        }
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let products = self.products {
            return products.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.rowHeight = 70
        
        let cell = tableView.dequeueReusableCell(withIdentifier: productCellIdentifier , for: indexPath) as! ProductsTableViewCell
        
        if let currentProduct = self.products?[indexPath.row] {
            if selectedProduct?.id == currentProduct.id {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                
                cell.contentView.layer.borderWidth = 1
                cell.contentView.layer.borderColor = UIColor().store_brown().cgColor
                
            } else {
                cell.contentView.layer.borderWidth = 0
                cell.contentView.layer.borderColor = UIColor.clear.cgColor
            }
            
            cell.configureCell(with: currentProduct)
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = products?[indexPath.row]
        
        tableView.reloadData()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}
