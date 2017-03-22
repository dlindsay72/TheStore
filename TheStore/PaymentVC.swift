//
//  PaymentVC.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-21.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

private let cellCreditCardIdentifier = "cellCreditCard"
private let cellTitleLabelIdentifier = "cellTitleLabel"
private let cellAddCardTitleIdentifier = "cellAddCardTitle"
private let cellAddNewCardIdentifier = "cellAddNewCard"



class PaymentVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var customer: Customer?
    var creditCards = [CreditCard]()
    var shoppingCart = ShoppingCart.sharedInstance
    var popInfoType: PopInfoType?
    var selectedIndexPath: IndexPath?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let customer = customer {
            let creditCardSet = customer.creditCard?.mutableCopy() as! NSMutableSet
            
            if creditCardSet.count > 0 {
                creditCards = creditCardSet.allObjects as! [CreditCard]
            }
        }
    }

    
    @IBAction func didTapExpMonth(_ sender: MyButton) {
        popInfoType = PopInfoType.ExpMonth
        showPopoverInfo(forSender: sender)
    }
    
    @IBAction func didTapExpYear(_ sender: MyButton) {
        popInfoType = PopInfoType.ExpYear
        showPopoverInfo(forSender: sender)
    }
}

// MARK: - UITableView Datasource and Delegate

extension PaymentVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 2, 3:
            return 1
        case 1:
            let rowCount = creditCards.count > 0 ? creditCards.count : 1
            return rowCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            tableView.rowHeight = 30
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTitleLabelIdentifier, for: indexPath)
            return cell
            
        case 1:
            tableView.rowHeight = 30
            let cell = tableView.dequeueReusableCell(withIdentifier: cellCreditCardIdentifier, for: indexPath) as! ExistingTableViewCell
            cell.accessoryType = .none
            
            let isCreditCardOnRecord = self.creditCards.count > 0 ? true : false
            cell.noCreditCardLabel.isHidden = isCreditCardOnRecord
            cell.cardTypeImageView.isHidden = !isCreditCardOnRecord
            cell.carNumberLabel.isHidden = !isCreditCardOnRecord
            cell.nameOnCardLabel.isHidden = !isCreditCardOnRecord
            cell.expirationLabel.isHidden = !isCreditCardOnRecord
            
            if isCreditCardOnRecord == true {
                let creditCard = self.creditCards[indexPath.row]
                cell.configureCell(withCreditCard: creditCard)
                
                if self.creditCards[indexPath.row] == shoppingCart.creditCard {
                    cell.accessoryType = .checkmark
                    selectedIndexPath = indexPath
                }
            }
            
            return cell
            
        case 2:
            tableView.rowHeight = 50
            let cell = tableView.dequeueReusableCell(withIdentifier: cellAddCardTitleIdentifier, for: indexPath)
            return cell
        case 3:
            tableView.rowHeight = 200
            let cell = tableView.dequeueReusableCell(withIdentifier: cellAddNewCardIdentifier, for: indexPath) as! NewCardTableViewCell
            cell.customer = customer
            cell.creditCardDelegate = self
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            if self.creditCards.count > 0 {
                shoppingCart.creditCard = self.creditCards[indexPath.row]
                
                if selectedIndexPath != nil && selectedIndexPath != indexPath {
                    tableView.cellForRow(at: selectedIndexPath!)?.accessoryType = .none
                    selectedIndexPath = indexPath
                }
                
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
        default:
            break
        }
    }
}

// MARK: - UIPopoverPresentationControllerDelegate

extension PaymentVC: UIPopoverPresentationControllerDelegate {
    internal func showPopoverInfo(forSender sender: UIButton) {
        let navController = storyboard?.instantiateViewController(withIdentifier: "navPopover") as! UINavigationController
        navController.modalPresentationStyle = .popover
        
        let popoverTVC = navController.topViewController as! PopoverTableVC
        popoverTVC.popInfoType = popInfoType
        popoverTVC.title = popInfoType?.rawValue
        popoverTVC.sender = sender
        popoverTVC.delegate = self
        
        let popoverController = navController.popoverPresentationController
        popoverController?.sourceView = sender
        popoverController?.sourceRect = sender.bounds
        popoverController?.permittedArrowDirections = .any
        popoverController?.delegate = self
        
        present(navController, animated: true, completion: nil)
    }
}

// MARK: - PopInfoSelectionDelegate

extension PaymentVC: PopInfoSelectionDelegate {
    func updateWithPopInfoSelection(value: String, sender: UIButton) {
        sender.setTitle(value, for: .normal)
    }
}

//MARK: - CreditCardDelegate

extension PaymentVC: CreditCardDelegate {
    func add(card: CreditCard) {
        self.shoppingCart.creditCard = card
        self.creditCards.append(card)
        
        tableView.reloadData()
    }
}












