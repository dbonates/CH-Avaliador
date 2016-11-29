//
//  Question.swift
//  Avaliador
//
//  Created by Daniel Bonates on 29/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import Foundation

struct Question {
    let question: String
    let score: Int
    let alternatives: [Alternative<Any>]?
}

extension Question {
    
    init?(json: QuestionDict) throws {
        
        guard
            let title = json["question"] as? String,
            let scoreString = json["score"] as? String,
            let score = Int(scoreString),
            let opt1 = json["option1"] as? String,
            let opt2 = json["option2"] as? String,
            let opt3 = json["option3"] as? String,
            let opt4 = json["option4"] as? String,
            let opt5 = json["option5"] as? String
            else { return nil }
        
        
        self.question = title
        self.score = score
        self.alternatives = [opt1, opt2, opt3, opt4, opt5].flatMap { alt in
            return Alternative<Any>(with: alt, isCorrect: alt == opt1)
        }
        
        self.alternatives?.shuffle()
    }
}
