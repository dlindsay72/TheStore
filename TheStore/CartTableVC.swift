//
//  CartTableVC.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-19.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

private let cartSegueIdentifier = "shoppingCartSegue"

class CartTableVC: UITableViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var checkoutButton: UIBarButtonItem!
    
    //MARK: Properties
    
    var shoppingCart = ShoppingCart.sharedInstance
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkoutButton.isEnabled = shoppingCart.totalItem() > 0 ? true : false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return shoppingCart.items.count
        case 1:
            return 1
        default:
            return 0
        }
        
    }
    
    // MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Review Items"
        default:
            return ""
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapContinueShopping(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

}
