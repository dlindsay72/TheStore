//
//  NewCardTableViewCell.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-21.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

enum CreditCardType: String {
    case Visa = "visa"
    case MC = "mastercard"
    case Amex = "amex"
    case Discover = "discover"
    case Unknown = "unknown"
}

protocol CreditCardDelegate: class {
    func add(card: CreditCard)
}

class NewCardTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var nameOnCardTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expirationMonthButton: MyButton!
    @IBOutlet weak var expirationYearButton: MyButton!
    
    //MARK: Properties
    var customer: Customer?
    weak var creditCardDelegate: CreditCardDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapAddCard(_ sender: MyButton) {
        guard let nameOnCard = nameOnCardTextField.text else {
            return
        }
        guard let cardNumber = cardNumberTextField.text else {
            return
        }
        guard let expMonth = expirationMonthButton.titleLabel?.text else {
            return
        }
        guard let expYear = expirationYearButton.titleLabel?.text else {
            return
        }
        
        let creditCard = CustomerService.addCreditCard(forCustomer: self.customer!, nameOnCard: nameOnCard, cardNumber: cardNumber, expMonth: Int(expMonth)!, expYear: Int(expYear)!)
        creditCardDelegate?.add(card: creditCard)
        
        //Reset credit card info
        nameOnCardTextField.text = ""
        cardNumberTextField.text = ""
        expirationMonthButton.setTitle("01", for: .normal)
        expirationYearButton.setTitle("\(Utility.currentYear())", for: .normal)
    }
    

}

















