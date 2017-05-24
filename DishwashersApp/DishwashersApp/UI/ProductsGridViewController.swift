//
//  ViewController.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 22/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class ProductsGridViewController: UICollectionViewController {

    enum Const {
        
        // Number of items returned in one page of search results
        static let defaultSearchPageSize = 20
    }
    
    // NOTE:
    // Application configuration is injected by Interface Builder
    // This is good enough for this excercise.
    //
    // In long term there would be an entity responsible for creating and providing the configuration
    // this could be an initial screen downloading additional settings from server
    @IBOutlet var appConfiguration: ApplicationConfiguration!
    
    fileprivate var products:[JohnLewisProduct]?
    fileprivate let defaultQueryString = "dishwashers"
    
    fileprivate var selectedProductDetails:JohnLewisProductDetails?
    fileprivate let spinnerView = LoadingSpinnerView()
}

extension ProductsGridViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }

}

extension ProductsGridViewController {
    
    func loadData() {
        
        // No need to load data if products are already there
        if products != nil {
            return
        }
        
        spinnerView.show(inView: self.view)
        let api = appConfiguration.apiAccess
        api?.getProductsGrid(query: defaultQueryString,
                             searchPageSize: Const.defaultSearchPageSize,
                             result: {[weak self] (p: [JohnLewisProduct]?) in

            self?.products = p
            DispatchQueue.main.async {
                self?.spinnerView.hide()
                self?.collectionView?.reloadData()
            }
            
        }, error: showApiError)
    }
    
    func showApiError(_ error: Error?) {

        let alert = UIAlertController(title: "Error",
                                      message: "Something went wrong",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async { [weak self] in
            self?.spinnerView.hide()
            self?.present(alert, animated: true, completion: nil)
        }

    }
}

// MARK: - UICollectionViewDataSource
extension ProductsGridViewController {
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let p = products else {
            return 0
        }
        
        return p.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let result = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as! ProductCell
        guard let p = products else {
            return result
        }
        
        let product = p[indexPath.item]
        result.update(withProduct: product, imagesProvider: appConfiguration.imagesProvider)
        return result
    }

}

// MARK: - UICollectionViewDelegate
extension ProductsGridViewController {
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        guard let p = products else {
            return
        }
        
        let itemIndex = indexPath.item
        let selectedProductId = p[itemIndex].productId
        
        let api = appConfiguration.apiAccess
        spinnerView.show(inView: self.view)
        api?.getProductDetails(productId: selectedProductId, result: { [weak self] (productDetails: JohnLewisProductDetails?) in
            
            guard let s = self else {
                return
            }
            s.selectedProductDetails = productDetails
            DispatchQueue.main.async {
                
                s.spinnerView.hide()
                s.performSegue(withIdentifier: "presentProductDetails", sender: self)
            }
        }, error: showApiError)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        guard
            identifier == "presentProductDetails",
            selectedProductDetails != nil else {
            return false
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "presentProductDetails",
            let productDetails = segue.destination as? ProductDetailsViewController,
            let product = selectedProductDetails else {
            return
        }
        
        productDetails.productDetails = product
        productDetails.imagesProvider = appConfiguration.imagesProvider
        
    }
}
