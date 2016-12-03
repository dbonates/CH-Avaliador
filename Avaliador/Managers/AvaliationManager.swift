//
//  AvaliationManager.swift
//  Avaliador
//
//  Created by Daniel Bonates on 29/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import Foundation

struct AvaliationManager {
    
    let questionsTotal: Int = 15
    
    let questions: [Question]
    var user: User
    
    var rate: Float {
        let maxScore = questions.map{$0.score}.reduce(0, +)
        return (Float(user.score) / Float(maxScore)) * 100
    }
}

extension AvaliationManager {
    
    init?(user: User) {
        
        guard
            let questionsJson = RequestManager.retrieveJsonFromFile(filenName: "perguntas"),
            let allQuestions = try? questionsJson.flatMap(Question.init) else { return nil }
        
        self.user = user
        let shuffledQuestions = allQuestions.shuffled()
        self.questions = Array(shuffledQuestions[0..<questionsTotal])
    }
}
