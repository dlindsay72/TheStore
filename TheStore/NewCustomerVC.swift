//
//  NewCustomerVC.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-20.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

private let newCustomerSegueIdentifier = "newCustomerSegue"
private let addAddressSegueIdentifier = "segueAddAddress"

class NewCustomerVC: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let navBack = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        self.navigationItem.leftBarButtonItem = navBack
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            switch identifier {
                case addAddressSegueIdentifier:
                    guard let name = nameTextField.text,
                        let email = emailTextField.text,
                        let password = passwordTextField.text,
                        name.characters.count > 0, email.characters.count > 0, password.characters.count > 0 else {
                        let alertController = UIAlertController(title: "Missing Information", message: "Please provide all the information for  name, email and password", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        
                        present(alertController, animated: true, completion: nil)
                        
                        return
                    }
                    let customer = CustomerService.addCustomer(name: name, email: email, password: password)
                    
                    let addressController = segue.destination as! AddressVC
                    addressController.customer = customer
                    
                default: break
                
            }
        }
        
    }
    
    
    //MARK: - IBActions

}
