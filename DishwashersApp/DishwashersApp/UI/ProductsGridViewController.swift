//
//  ViewController.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 22/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class ProductsGridViewController: UICollectionViewController {

    @IBOutlet var appConfiguration: ApplicationConfiguration!
    
    fileprivate var products:[JohnLewisProduct] = []
    fileprivate let defaultQueryString = "dishwashers"
    
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
        api?.getProductsGrid(query: defaultQueryString, result: {[weak self] (p: [JohnLewisProduct]) in
            // TODO: Dismiss spinner
            self?.products = p
            self?.collectionView?.reloadData()
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
        result.update(withProduct: product)
        return result
    }

}

// MARK: - UICollectionViewDelegate
extension ProductsGridViewController {
    
}