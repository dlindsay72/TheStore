//
//  HomeVC.swift
//  TheStore
//
//  Created by Dan Lindsay on 2017-03-15.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit



class HomeVC: UIViewController {
    
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var pageView: UIView!
    
    // MARK: - Properties
    
    var pageViewController: UIPageViewController?
    let arrayPageImage = ["piratebattle", "piratemap", "piratesofcaribbean"]
    private let promoPageIdentifier = "promoPageVC"
    private let promoContentIdentifier = "promoContentVC"
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setPageViewController()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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





















