//
//  LoginVC.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-20.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

private let startCheckoutSegueIdentifier = "startCheckoutSegue"
private let shipAddressSegueIdentifier = "shipAddressSegue"

class LoginVC: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: Properties
    var customer: Customer?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
                case shipAddressSegueIdentifier:
                    let addressController = segue.destination as! AddressVC
                    addressController.customer = customer
                default:
                    break
            }
        }
    }
 
    
    // MARK: - IBActions
    
    
    @IBAction func didTapCancel(_ sender: UIBarButtonItem) {
       dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didTapSignIn(_ sender: MyButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        customer = CustomerService.verify(username: email, password: password)
        
        if customer != nil {
            performSegue(withIdentifier: shipAddressSegueIdentifier, sender: self)
        } else {
            let alertController = UIAlertController(title: "Login Failed", message: "We do not recognize your email and/or password. \nPlease try again.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction) in
                DispatchQueue.main.async {
                    self?.emailTextField.text = ""
                    self?.passwordTextField.text = ""
                }
            })
            
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindFromCreateAccount(segue: UIStoryboardSegue) {
        print("back from create account scene")
    }
    
    

}
