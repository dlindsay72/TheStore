//
//  OrderConfirmationVC.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-22.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class OrderConfirmationVC: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var orderConfirmationNumberLabel: UILabel!
    
    //MARK: Properties
    
    var shoppingCart = ShoppingCart.sharedInstance
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        orderConfirmationNumberLabel.text = UUID().uuidString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapContinueShopping(_ sender: MyButton) {
        dismiss(animated: true, completion: nil)
        shoppingCart.reset()
    }
    

}
