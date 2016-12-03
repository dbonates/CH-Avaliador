//
//  BasicControls.swift
//  Avaliador
//
//  Created by Daniel Bonates on 29/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import UIKit

struct BasicControls {
    
    static func basicLabel(fontSize: CGFloat, bold: Bool = false) -> UILabel {
        
        let basicLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 64))
        basicLabel.translatesAutoresizingMaskIntoConstraints = false
        basicLabel.font = bold ? UIFont.boldSystemFont(ofSize: fontSize): UIFont.systemFont(ofSize: fontSize)
        basicLabel.lineBreakMode = .byWordWrapping
        basicLabel.numberOfLines = 0
        basicLabel.textColor = ThemeManager.textColor
        
        return basicLabel
    }
    
    static func basicInput(placeholder: String) -> UITextField {
        
        let basicInput = UITextField(frame: CGRect(x: 0, y: 0, width: 280, height: 44))
        basicInput.textColor = .white
        basicInput.attributedPlaceholder = NSAttributedString(string:placeholder, attributes:[NSForegroundColorAttributeName: ThemeManager.placeHolderColor])
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: basicInput.bounds.height - 1, width: basicInput.bounds.width, height: 1)
        bottomLine.backgroundColor = basicInput.textColor?.cgColor
        basicInput.layer.addSublayer(bottomLine)
        
        return basicInput
    }
    
    static func basicButton(title: String, bold: Bool = false) -> UIButton {
        
        let fontSize: CGFloat = ThemeManager.baseFontSize
        let basicButton = UIButton(frame: CGRect(x: 0, y: 0, width: 280, height: 44))
        basicButton.titleLabel?.lineBreakMode = .byWordWrapping
        basicButton.titleLabel?.font = bold ? UIFont.boldSystemFont(ofSize: fontSize): UIFont.systemFont(ofSize: fontSize)
        basicButton.setTitle(title, for: .normal)
        basicButton.setTitleColor(ThemeManager.buttonTextColorNormal, for: .normal)
        basicButton.setTitleColor(ThemeManager.buttonTextColorHighlighted, for: .highlighted)
        basicButton.backgroundColor = ThemeManager.buttonBackgroundColor
        basicButton.layer.cornerRadius = ThemeManager.baseMargin / 2
        return basicButton
    }
    
    static func basicOptionButton(tag: Int, frame: CGRect) -> UIButton {
        
        let basicButton = UIButton(frame: frame)
        basicButton.tag = tag
        basicButton.contentHorizontalAlignment = .left
        basicButton.contentVerticalAlignment = .top
        basicButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: ThemeManager.baseMargin, bottom: 0, right: ThemeManager.baseMargin)
        basicButton.imageEdgeInsets = UIEdgeInsets(top: 3, left: ThemeManager.baseMargin, bottom: -3, right: 0)
        basicButton.setImage(UIImage(named: "unselected"), for: .normal)
        basicButton.setImage(UIImage(named: "unselected"), for: .highlighted)
        basicButton.setImage(UIImage(named: "selected"), for: .selected)
        
        return basicButton
    }
}


