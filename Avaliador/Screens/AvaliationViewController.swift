//
//  AvaliationViewController.swift
//  Avaliador
//
//  Created by Daniel Bonates on 29/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import UIKit

class AvaliationViewController: UIViewController {
    
    var avaliationManager: AvaliationManager!
    
    var currentQuestionIndex: Int = 0
    var statusInfoLabel: UILabel!
    var currentUserInfo: UILabel!
    var questionTitleLabel: UILabel!
    
    var alternativeLabels = [UILabel]()
    var alternativeButtons = [UIButton]()
    var selectedOption: Int = -1
    
    var statusUpdatedInfo: String {
        get {
            return "Questão \(currentQuestionIndex + 1) de \(avaliationManager.questions.count)"
        }
    }
    
    var userInfo: String {
        return avaliationManager.user.email
    }
    
    convenience init(for user: User) {
        
        self.init(nibName: nil, bundle: nil)
        avaliationManager = AvaliationManager(user: user)
        buidlUI()
    }
    
    func buidlUI() {
        buildHeader()
        buildQuestionView()
        startAvaliation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white    
        title = "Avaliação"
    }
    
    
    func startAvaliation() {
        showCurrentQuestion()
    }
    
    
    func showCurrentQuestion() {
        
        clearSelection()
        selectedOption = -1
        
        let currentQuestion = avaliationManager.questions[currentQuestionIndex]
        statusInfoLabel.text = statusUpdatedInfo
        
        
        UIView.transition(with: questionTitleLabel, duration: 0.2, options: [.transitionCrossDissolve], animations: {
            self.questionTitleLabel.text = currentQuestion.question
        }, completion: nil)
        
        
        let transitionType = UIViewAnimationOptions.transitionFlipFromBottom
        
        guard let alternatives = currentQuestion.alternatives else { return }
        
        for (idx, alternativeLabel) in alternativeLabels.enumerated() {
            alternativeLabel.displayText(text: alternatives[idx].text, duration: 0.1 * Double(0 + idx), transitionType: transitionType)
        }
    }
    
    func confirmTapped() {
        
        computeSelection()
        
        guard currentQuestionIndex < avaliationManager.questions.count - 1 else {
            showSummary()
            return
        }
        
        
        currentQuestionIndex += 1
        showCurrentQuestion()
    }
    
    func computeSelection() {
        
        guard selectedOption >= 0, let alternative = avaliationManager.questions[currentQuestionIndex].alternatives?[selectedOption] else { return }
        
        if alternative.isCorrect {
            avaliationManager.user.score += avaliationManager.questions[currentQuestionIndex].score
        }
    }
    
    func showSummary() {
        
        let endScreen = EndScreen()
        endScreen.userRate = avaliationManager.rate
        endScreen.user = avaliationManager.user
        navigationController?.pushViewController(endScreen, animated: true)
    }
    
    
    // MARK: UI Building
    func buildHeader() {
        statusInfoLabel = BasicControls.basicLabel(fontSize: ThemeManager.baseFontSize * 3, bold: true)
        statusInfoLabel.text = "status info"
        view.addSubview(statusInfoLabel)
        statusInfoLabel.align(attribute: .left, offset: ThemeManager.baseMargin)
        statusInfoLabel.align(attribute: .right, offset: ThemeManager.baseMargin)
        statusInfoLabel.align(attribute: .top, offset: ThemeManager.baseMargin * 2)
        
        currentUserInfo = BasicControls.basicLabel(fontSize: ThemeManager.baseFontSize, bold: true)
        currentUserInfo.translatesAutoresizingMaskIntoConstraints = false
        currentUserInfo.text = userInfo
        view.addSubview(currentUserInfo)
        currentUserInfo.align(attribute: .left, offset: ThemeManager.baseMargin)
        currentUserInfo.align(attribute: .right, offset: -ThemeManager.baseMargin)
        currentUserInfo.align(attribute: .top, withAttribute: .bottom, ofView: statusInfoLabel)
    }
    
    
    
    func buildQuestionView() {
        
        let fontSize: CGFloat = ThemeManager.baseFontSize
        
        questionTitleLabel = BasicControls.basicLabel(fontSize: fontSize * 1.3, bold: true)
        questionTitleLabel.text = "titulo da questão"
        view.addSubview(questionTitleLabel)
        questionTitleLabel.align(attribute: .left, offset: ThemeManager.baseMargin)
        questionTitleLabel.align(attribute: .right, offset: -ThemeManager.baseMargin)
        questionTitleLabel.align(attribute: .top, withAttribute: .bottom, ofView: currentUserInfo, offset: ThemeManager.baseMargin * 2)
        
        let alternativesCount = 5 // should be dynamic in the future, a question could be true/false, for example
        for idx in 0..<alternativesCount {
            
            let alternativeLabel = BasicControls.basicLabel(fontSize: fontSize)
            alternativeLabels.append(alternativeLabel)
            view.addSubview(alternativeLabel)
            
            let topOffset = idx == 0 ? ThemeManager.baseMargin * 2 : ThemeManager.baseMargin
            let upperView = idx == 0 ? questionTitleLabel : alternativeLabels[idx-1]
            alternativeLabel.align(attribute: .left, offset: ThemeManager.baseMargin * 2)
            alternativeLabel.align(attribute: .right, offset: -ThemeManager.baseMargin)
            alternativeLabel.align(attribute: .top, withAttribute: .bottom, ofView: upperView!, offset: CGFloat(topOffset))
                
            addButtonsForOptions(for: alternativeLabel, answerTag: idx)
            
        }
        
        
        let confirmButton = BasicControls.basicButton(title: "Confirmar")
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        view.addSubview(confirmButton)
        
        confirmButton.keepDimensions()
        confirmButton.centerHorizontalyOnSuperview()
        confirmButton.align(attribute: .bottom, offset: -40)
        
    }
    
    
    func addButtonsForOptions(for label:UILabel, answerTag: Int) {
        let buttonOption = BasicControls.basicOptionButton(tag: answerTag, frame: CGRect.zero)
        alternativeButtons.append(buttonOption)
        buttonOption.addTarget(self, action: #selector(optionSelected(sender:)), for: .touchUpInside)
        buttonOption.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonOption)
        buttonOption.align(attribute: .top, withAttribute: .top, ofView: label)
        buttonOption.align(attribute: .height, withAttribute: .height, ofView: label)
        buttonOption.align(attribute: .width, withAttribute: .width, ofView: view)
    }
    
    func optionSelected(sender: UIButton) {
                
        clearSelection()
        selectedOption = sender.tag
        sender.isSelected = true
    }
    
    
    func clearSelection() {
        
        guard selectedOption != -1, !alternativeButtons.isEmpty else { return }
        
        for btn in alternativeButtons {
            btn.isSelected = false
        }
    }
    
}


