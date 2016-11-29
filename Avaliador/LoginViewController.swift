//
//  LoginViewController.swift
//  Avaliador
//
//  Created by Daniel Bonates on 29/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var nameInput: UITextField!
    var emailInput: UITextField!
    
    override func viewDidLoad() {
        self.title = "Bem Vindo!"
        buildUI()
    }
    
    func buildUI() {
        view.backgroundColor = .white
        
        let introLabel: UILabel = BasicControls.basicLabel(fontSize: ThemeManager.baseFontSize)
        introLabel.text = "Seja vem vindo ao Teste iOS da Primeira Cocoaheads Conference 2016! Sortearemos algumas perguntas relacionadas a diferentes níveis de conhecimento que irão ajudar a identificar o quanto você sabe sobre iOS, e talvez, pontos de interesse a serem desenvolvidos no assunto.\n\nEsse teste tem a pretenção de ser apenas uma ferramenta auxiliar, logo o resultado do teste é particular e NÃO será armazenado ou divulgado de nenhuma forma.\n\nO teste começa com o preenchimento do seu nome e email abaixo. Por favor preencha os campos e use o botão \"Iniciar Teste\"."
        view.addSubview(introLabel)
        introLabel.align(attribute: .left, offset: ThemeManager.baseMargin * 2)
        introLabel.align(attribute: .right, offset: -ThemeManager.baseMargin * 2)
        introLabel.align(attribute: .top, offset: ThemeManager.baseMargin * 3)
        
        nameInput = BasicControls.basicInput(placeholder: "seu nome aqui")
        view.addSubview(nameInput)
        
        nameInput.keepDimensions()
        nameInput.centerHorizontalyOnSuperview()
        nameInput.align(attribute: .top, withAttribute: .bottom, ofView: introLabel, offset: ThemeManager.baseMargin * 2)
        
        emailInput = BasicControls.basicInput(placeholder: "seu email")
        emailInput.autocapitalizationType = .none
        view.addSubview(emailInput)
        
        emailInput.keepDimensions()
        emailInput.align(attribute: .top, withAttribute: .bottom, ofView: nameInput, offset: 10)
        emailInput.align(attribute: .left, withAttribute: .left, ofView: nameInput)
        
        let loginButton = BasicControls.basicButton(title: "Iniciar Teste")
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        loginButton.keepDimensions()
        loginButton.centerHorizontalyOnSuperview()
        loginButton.align(attribute: .top, withAttribute: .bottom, ofView: emailInput, offset: ThemeManager.baseMargin)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        
        nameInput.text = ""
        emailInput.text = ""
        
        nameInput.becomeFirstResponder()
    }
    
    func loginTapped() {
        guard let name = nameInput.text, !name.isEmpty, let email = emailInput.text, !email.isEmpty, isValidEmail(emailStr: email), let user = User(name: name, email: email) else {
            emailInput.text = ""
            emailInput.placeholder = "por favor, um email válido!"
            return
        }
        
        let avalVc = AvaliationViewController(for: user)
        navigationController?.pushViewController(avalVc, animated: true)
    }
    
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: emailStr)
        return result
    }
}
