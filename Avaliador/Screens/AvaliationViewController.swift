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
    var option1Label: UILabel!
    var option2Label: UILabel!
    var option3Label: UILabel!
    var option4Label: UILabel!
    var option5Label: UILabel!
    
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
        
        questionTitleLabel.text = currentQuestion.question
        option1Label.text = currentQuestion.alternatives?[0].content as? String
        option2Label.text = currentQuestion.alternatives?[1].content as? String
        option3Label.text = currentQuestion.alternatives?[2].content as? String
        option4Label.text = currentQuestion.alternatives?[3].content as? String
        option5Label.text = currentQuestion.alternatives?[4].content as? String
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
        
        
        option1Label = BasicControls.basicLabel(fontSize: fontSize)
        view.addSubview(option1Label)
        option2Label = BasicControls.basicLabel(fontSize: fontSize)
        view.addSubview(option2Label)
        option3Label = BasicControls.basicLabel(fontSize: fontSize)
        view.addSubview(option3Label)
        option4Label = BasicControls.basicLabel(fontSize: fontSize)
        view.addSubview(option4Label)
        option5Label = BasicControls.basicLabel(fontSize: fontSize)
        view.addSubview(option5Label)
        
        let optArray = [option1Label, option2Label, option3Label, option4Label, option5Label]
        
        for idx in 0..<5 {
            
            let topOffset = idx == 0 ? ThemeManager.baseMargin * 2 : ThemeManager.baseMargin
            let upperView = idx == 0 ? questionTitleLabel : optArray[idx-1]
            if let optLbl = optArray[idx] {
                optLbl.align(attribute: .left, offset: ThemeManager.baseMargin * 2)
                optLbl.align(attribute: .right, offset: -ThemeManager.baseMargin)
                optLbl.align(attribute: .top, withAttribute: .bottom, ofView: upperView!, offset: CGFloat(topOffset))
                
                addButtonsForOptions(for: optLbl, answerTag: idx)
                
            }
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


