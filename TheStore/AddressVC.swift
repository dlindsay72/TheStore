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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
