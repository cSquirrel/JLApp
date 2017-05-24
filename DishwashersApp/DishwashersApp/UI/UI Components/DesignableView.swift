//
//  DesignableView.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 24/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class DesignableView: UIView {

    override func awakeFromNib() {
        setupView()
    }
    
    /**
     * Called by Interface Builder to render live preview
     */
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        
        let selfType = type(of:self)
        let bundle = Bundle(for: selfType)
        let nib = UINib.init(nibName: "\(selfType)", bundle: bundle)
        let views = nib.instantiate(withOwner: self, options: nil)
        guard let view = views.first as? UIView else {
            return
        }
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = self.bounds
        self.addSubview(view)
    }

}
