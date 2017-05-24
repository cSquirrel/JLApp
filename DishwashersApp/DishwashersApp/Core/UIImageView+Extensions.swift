//
//  UIImageView+Extensions.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 24/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /**
     * Redraw image to match image view's bound's size.
     * This method reduces memory consumption when setting large image.
     */
    func setImage(_ image: UIImage, scale scaleImage: Bool = true) {
        
        guard scaleImage else {
            self.image = image
            return
        }
        
        let size = self.bounds.size
        let hasAlpha = false
        // Apple doc: If you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen.
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.image = scaledImage
    }
}
