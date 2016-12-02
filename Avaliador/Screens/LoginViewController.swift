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
    var logoImgView: UIImageView!
    
    override func viewDidLoad() {
        self.title = "Bem Vindo!"
        buildUI()
    }
    
    func buildUI() {
        view.backgroundColor = UIColor.mainGreen
        
        
        logoImgView = UIImageView(image: UIImage(named: "cocoaheads_teammember"))
        logoImgView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImgView)
        logoImgView.align(attribute: .top, offset: ThemeManager.baseMargin * 2)
        logoImgView.align(attribute: .centerX, withAttribute: .centerX, ofView: view)
        
        let introLabel: UILabel = BasicControls.basicLabel(fontSize: ThemeManager.baseFontSize)
        introLabel.textColor = .white
        introLabel.textAlignment = .center
        
        let cleanText = "Bem vindo à\nCocoaheads Conference 2016\n\nPara iniciar o teste, Por favor preencha os campos e use o botão \"Iniciar Teste\"."
        
        let defaultAttributes:[String:AnyObject] = [NSFontAttributeName: introLabel.font, NSForegroundColorAttributeName: UIColor.white]
        
        let wellcomeAttributes:[String:AnyObject] = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: ThemeManager.baseFontSize * 1.2) , NSForegroundColorAttributeName: UIColor.breaktimeColor]
        
        let attrStr = NSMutableAttributedString(string: cleanText, attributes: defaultAttributes)
        
        attrStr.addAttributes(wellcomeAttributes, range: cleanText.NS.range(of: "Cocoaheads Conference 2016"))

        introLabel.attributedText = attrStr
        
        view.addSubview(introLabel)
        introLabel.align(attribute: .left, offset: ThemeManager.baseMargin * 3)
        introLabel.align(attribute: .right, offset: -ThemeManager.baseMargin * 3)
        introLabel.align(attribute: .top, withAttribute: .bottom, ofView: logoImgView, offset: ThemeManager.baseMargin)
        
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
