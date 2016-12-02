//
//  Alternative.swift
//  Avaliador
//
//  Created by Daniel Bonates on 29/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import Foundation

// can be text or image
struct Alternative<T> {
    let isCorrect: Bool
    let content: T?
}

extension Alternative {
    
    var text: String {
        get {
            guard let textContent = self.content as? String else { return "" }
            return textContent
        }
    }
    
    init?(with content: Any, isCorrect: Bool) {
        self.content = content as? T
        self.isCorrect = isCorrect
    }
}
