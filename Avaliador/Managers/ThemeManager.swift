//
//  ThemeManager.swift
//  Avaliador
//
//  Created by Daniel Bonates on 29/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import UIKit

struct ThemeManager {
    static let textColor: UIColor = .gray
    static let buttonTextColorNormal: UIColor = .actionColor
    static let buttonTextColorHighlighted: UIColor = .breaktimeColor
    static let buttonBackgroundColor: UIColor = .white
    static let placeHolderColor: UIColor = UIColor(hexString: "#0E6F48")
    
    static var baseFontSize: CGFloat = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ? 22 : 16
    static var baseMargin: CGFloat = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ? 30 : 10
    
}
