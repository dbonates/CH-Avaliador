//
//  UIView+Extensions.swift
//  Avaliador
//
//  Created by Daniel Bonates on 29/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import UIKit

extension UIView {
    
    func keepDimensions() {
        self.translatesAutoresizingMaskIntoConstraints = false
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: bounds.width))
        
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: bounds.height))
    }
    
    func align(attribute: NSLayoutAttribute, offset: CGFloat = 0) {
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: self.superview!, attribute: attribute, multiplier: 1.0, constant: offset))
    }
    
    func align(attribute: NSLayoutAttribute, toView: UIView, offset: CGFloat = 0) {
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: toView, attribute: attribute, multiplier: 1.0, constant: offset))
    }
    
    
    func align(attribute: NSLayoutAttribute, withAttribute: NSLayoutAttribute, ofView: UIView, offset: CGFloat = 0) {
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: ofView, attribute: withAttribute, multiplier: 1.0, constant: offset))
    }
    
    func centerInSuperview() {
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview!, attribute: .centerX, multiplier: 1.0, constant: 0))
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview!, attribute: .centerY, multiplier: 1.0, constant: 0))
    }
    
    func centerHorizontalyOnSuperview() {
        superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview!, attribute: .centerX, multiplier: 1.0, constant: 0))
    }
}
