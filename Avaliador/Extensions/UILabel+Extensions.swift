//
//  UILabel+Extensions.swift
//  Avaliador
//
//  Created by Daniel Bonates on 02/12/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import UIKit

extension UILabel {
    
    func displayText(text: String, duration: TimeInterval, transitionType: UIViewAnimationOptions) {
        UIView.transition(with: self, duration: duration, options: [transitionType], animations: {
            self.text = text
        }, completion: nil)
    }
}
