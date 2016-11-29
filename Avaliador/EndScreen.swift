//
//  EndScreen.swift
//  Avaliador
//
//  Created by Daniel Bonates on 29/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import UIKit

class EndScreen: UIViewController {
    
    var endMessageLabel: UILabel!
    var userRate: Float = 0
    
    var user: User! {
        didSet {
            updateUserFeedback()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    func buildUI() {
        
        endMessageLabel = BasicControls.basicLabel(fontSize: ThemeManager.baseFontSize * 2)
        endMessageLabel.text = "Obrigado por participar do teste. \n\nPara fechar o teste, bastar tocar em \"Encerrar\"."
        
        view.addSubview(endMessageLabel)
        endMessageLabel.align(attribute: .left, offset: ThemeManager.baseMargin * 2)
        endMessageLabel.align(attribute: .right, offset: -ThemeManager.baseMargin * 2)
        endMessageLabel.align(attribute: .top, offset: ThemeManager.baseMargin * 3)
        
        let finishButton = BasicControls.basicButton(title: "Encerrar")
        finishButton.addTarget(self, action: #selector(finishTapped), for: .touchUpInside)
        view.addSubview(finishButton)
        
        finishButton.keepDimensions()
        finishButton.centerHorizontalyOnSuperview()
        finishButton.align(attribute: .bottom, offset: -ThemeManager.baseMargin * 2)
        
    }
    
    func updateUserFeedback() {
        
        endMessageLabel.text = "Obrigado por participar do teste, \(user.name)! Seu resultado foi:\n\n \(user.score) pontos, correspondendo a \(Int(userRate))% de aproveitamento da avaliação. \n\n\nPara fechar o teste, bastar usar o botão \"Encerrar\"."
    }
    
    func finishTapped() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
}
