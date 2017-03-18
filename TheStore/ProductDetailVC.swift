//
//  ProductDetailVC.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-17.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

private let productInfoCellIdentifier = "productInfoCell"

class ProductDetailVC: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var detailSummaryView: DetailSummaryView!
    @IBOutlet weak var productDescriptionImageView: UIImageView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var product: Product? {
        didSet {
            if let currentProduct = product {
                self.showDetail(for: currentProduct)
            }
        }
    }
    
    var specifications = [ProductInfo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Function
    
    private func showDetail(for currentProduct: Product) {
        if viewIfLoaded != nil {
            detailSummaryView.updateView(with: currentProduct)
            
            let productInfo = currentProduct.productInfo?.allObjects as! [ProductInfo]
            specifications = productInfo.filter({ $0.type == "specs" })
            
            var description = ""
            
            for currentInfo in productInfo {
                if let info = currentInfo.info, info.characters.count > 0, currentInfo.type == "description" {
                    description = description + info + "\n\n"
                }
            }
            
            productDescriptionLabel.text = description
            productDescriptionImageView.image = Utility.image(withName: currentProduct.mainImage, andType: "jpg")
            tableView.reloadData()
        }
    }
   

}

// MARK: - UITableViewDatasource

extension ProductDetailVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: productInfoCellIdentifier, for: indexPath) as! ProductInfoTableViewCell
        
        cell.productInfo = specifications[indexPath.row]
        
        return cell
    }
    
    
}











