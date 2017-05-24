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
    
    @IBOutlet var appConfiguration: ApplicationConfiguration!
    
    fileprivate var products:[JohnLewisProduct] = []
    fileprivate let defaultQueryString = "dishwashers"
    
    var selectedProductDetails:JohnLewisProductDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ProductsGridViewController {
    
    func reloadData() {
        
        // TODO: Display spinner
        let api = appConfiguration.apiAccess
        api?.getProductsGrid(query: defaultQueryString,
                             searchPageSize: Const.defaultSearchPageSize,
                             result: {[weak self] (p: [JohnLewisProduct]) in
            // TODO: Dismiss spinner
            self?.products = p
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
            
        })
    }
}

// MARK: - UICollectionViewDataSource
extension ProductsGridViewController {
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let product = products[indexPath.item]
        let result = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as! ProductCell
        result.update(withProduct: product, imagesProvider: appConfiguration.imagesProvider)
        return result
    }

}

// MARK: - UICollectionViewDelegate
extension ProductsGridViewController {
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let itemIndex = indexPath.item
        let selectedProductId = products[itemIndex].productId
        
        // TODO: fetch product details
        let api = appConfiguration.apiAccess
        api?.getProductDetails(productId: selectedProductId, result: { [unowned self] (productDetails: JohnLewisProductDetails) in
            self.selectedProductDetails = productDetails
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "presentProductDetails", sender: self)
            }
            
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "presentProductDetails",
            let productDetails = segue.destination as? ProductDetailsViewController,
            let product = selectedProductDetails else {
            return
        }
        
        productDetails.selectedProductDetails = product
        productDetails.imagesProvider = appConfiguration.imagesProvider
        
    }
}
