//
//  HomeVC.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-15.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit

private let toyCell = "toyCell"
private let dvdCell = "dvdCell"
private let promoPageIdentifier = "promoPageVC"
private let promoContentIdentifier = "promoContentVC"

class HomeVC: UIViewController {
    
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var toyCollectionView: UICollectionView!
    
    @IBOutlet weak var dvdCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    var pageViewController: UIPageViewController?
    let arrayPageImage = ["piratebattle", "piratemap", "piratesofcaribbean"]
    var currentIndex = 0
    var toysCollection = [Product]()
    var dvdCollection = [Product]()
    var selectedProduct: Product?
    var productsInSelectedCategory: [Product]?
    var productTVC: ProductsTableVC?
    
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(HomeVC.loadNextController), userInfo: nil, repeats: true)

        setPageViewController()
        loadProducts()
    }

    // MARK: - Private Functions
    
    private func setPageViewController() {
        let pageVC = self.storyboard?.instantiateViewController(withIdentifier: promoPageIdentifier) as! UIPageViewController
        pageVC.dataSource = self
        
        
        let firstController = getViewController(atIndex: 0)
        
        pageVC.setViewControllers([firstController], direction: .forward, animated: true, completion: nil)
        self.pageViewController = pageVC
        
        self.addChildViewController(self.pageViewController!)
        self.pageView.addSubview(self.pageViewController!.view)
        self.pageViewController?.didMove(toParentViewController: self)
        
    }
    
    fileprivate func getViewController(atIndex index: Int) -> PromoContentVC {
        let promoContentVC = self.storyboard?.instantiateViewController(withIdentifier: promoContentIdentifier) as! PromoContentVC
        
        promoContentVC.imageName = arrayPageImage[index]
        promoContentVC.pageIndex = index
        
        return promoContentVC
    }
    
    @objc private func loadNextController() {
        currentIndex += 1
        
        if currentIndex == arrayPageImage.count {
            currentIndex = 0
        }
        
        let nextController = getViewController(atIndex: currentIndex)
        
        self.pageViewController?.setViewControllers([nextController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        self.pageControl.currentPage = currentIndex
    }
    
    private func loadProducts() {
        toysCollection = ProductService.products(category: "toy")
        dvdCollection = ProductService.products(category: "dvd")
    }
    
    @IBAction func unwindFromOrderConfirmation(segue: UIStoryboardSegue) {
        print("Coming from Order Confirmation")
    }

}

// MARK: - UIPageViewControllerDataSource

extension HomeVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContentVC = viewController as! PromoContentVC
        var index = pageContentVC.pageIndex
        
        if index == 0 || index == NSNotFound {
            return getViewController(atIndex: arrayPageImage.count - 1)
            
            // 0 | 1 | 2 | 0 | 1 | 2 | ....
        }
        
        index -= 1
        
        return getViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContentVC = viewController as! PromoContentVC
        var index = pageContentVC.pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if index == arrayPageImage.count {
            return getViewController(atIndex: 0)
        }
        return getViewController(atIndex: index)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            
            case self.toyCollectionView:
                return self.toysCollection.count
                
            case self.dvdCollectionView:
                return self.dvdCollection.count
                
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.toyCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: toyCell, for: indexPath) as! ProductCollectionViewCell
            let product = toysCollection[indexPath.row]
            cell.productImageView.image = Utility.image(withName: product.mainImage, andType: "jpg")
            
            return cell
            
        case self.dvdCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dvdCell, for: indexPath) as! ProductCollectionViewCell
            let product = dvdCollection[indexPath.row]
            cell.productImageView.image = Utility.image(withName: product.mainImage, andType: "jpg")
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.toyCollectionView:
            selectedProduct = toysCollection[indexPath.row]
            productsInSelectedCategory = toysCollection
        case self.dvdCollectionView:
            selectedProduct = dvdCollection[indexPath.row]
            productsInSelectedCategory = dvdCollection
        default:
            print("Nothing has been picked")
        }
        
        self.productTVC?.products = productsInSelectedCategory
        self.productTVC?.selectedProduct = selectedProduct
        
        self.parent?.tabBarController?.selectedIndex = 1
    }
}





















