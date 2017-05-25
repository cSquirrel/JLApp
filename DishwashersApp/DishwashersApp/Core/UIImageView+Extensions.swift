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
        
        let imgScale:CGFloat
        if (self.bounds.size.width > self.bounds.size.height) {
            imgScale = self.bounds.size.width / image.size.width
        } else {
            imgScale = self.bounds.size.height / image.size.height
        }
        
        let hasAlpha = false
        // Apple doc: If you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen.
        let scale: CGFloat = 0.0
        
        let imgSize = CGSize(width: floor(image.size.width * imgScale),
                             height: floor(image.size.height * imgScale))
        UIGraphicsBeginImageContextWithOptions(imgSize, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: imgSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.image = scaledImage
    }
}
