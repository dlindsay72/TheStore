//
//  AddressVC.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-20.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

class AddressVC: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var addressPickerView: UIPickerView!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var address1TextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var noAddressLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - Properties
    var customer: Customer?
    var addresses = [Address]()
    var selectedAddress: Address?
    var activeTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        registerForKeyboardNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addressPickerView.isHidden = false
        noAddressLabel.isHidden = true
        
        if let customer = customer {
            addresses = CustomerService.addressList(forCustomer: customer)
            
            if addresses.count == 0 {
                addressPickerView.isHidden = true
                noAddressLabel.isHidden = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private Functions
    
    private func registerForKeyboardNotification() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(AddressVC.keyboardIsOn(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(AddressVC.keyboardIsOff(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardIsOn(sender: Notification) {
        let info: NSDictionary = sender.userInfo! as NSDictionary
        let value: NSValue = info.value(forKey: UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize = value.cgRectValue.size
        
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height - 50, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardIsOff(sender: Notification) {
        scrollView.setContentOffset(CGPoint(x: 0, y: -50), animated: true)
        scrollView.isScrollEnabled = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UIPickerView DataSource and Delegate

extension AddressVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addresses.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let address = addresses[row]
        
        return "\(address.address1) \(address.address2), \(address.city), \(address.state) \(address.zip)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedAddress = addresses[row]
    }
}

// MARK: - UITextField Delegate

extension AddressVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        scrollView.isScrollEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        activeTextField = nil
        
        return true
    }
}





















