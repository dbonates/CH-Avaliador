//
//  RequestManager.swift
//  Avaliador
//
//  Created by Daniel Bonates on 29/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import Foundation

typealias QuestionDict = [String:Any]

struct RequestManager { }
extension RequestManager {
    
    static func retrieveJsonFromFile(filenName:String) -> [QuestionDict]? {
        
        guard
            let url = Bundle.main.url(forResource: filenName, withExtension: "json"),
            let jsonData = try? Data(contentsOf: url, options: []),
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [QuestionDict] else { return nil }
        
        return json
        
    }
    
}
