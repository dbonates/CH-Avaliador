//
//  EndScreen.swift
//  Avaliador
//
//  Created by Daniel Bonates on 29/11/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import UIKit
import CoreData

class EndScreen: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext? = nil
    var endMessageLabel: UILabel!
    var userRate: Float = 0
    var headerBgView: UIView!
    var currentUserInfo: UILabel!
    
    var user: User! {
        didSet {
            buildHeader()
            updateUserFeedback()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
       
        buildHeader()
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    
    
    func buildUI() {
        
        endMessageLabel = BasicControls.basicLabel(fontSize: ThemeManager.baseFontSize * 1.2)
        endMessageLabel.textAlignment = .center
        endMessageLabel.textColor = .mainGreen
        endMessageLabel.text = "Obrigado por participar do teste. \n\nPara fechar o teste, \nbastar tocar em \"Encerrar\"."
        
        view.addSubview(endMessageLabel)
        endMessageLabel.align(attribute: .left, offset: ThemeManager.baseMargin * 2)
        endMessageLabel.align(attribute: .right, offset: -ThemeManager.baseMargin * 2)
        endMessageLabel.align(attribute: .top, withAttribute: .bottom, ofView: headerBgView, offset: ThemeManager.baseMargin * 3)
        
        let finishButton = BasicControls.basicButton(title: "Encerrar")
        finishButton.addTarget(self, action: #selector(finishTapped), for: .touchUpInside)
        view.addSubview(finishButton)
        
        finishButton.keepDimensions()
        finishButton.centerHorizontalyOnSuperview()
        finishButton.align(attribute: .bottom, offset: -ThemeManager.baseMargin * 2)
        
    }
    
    func buildHeader() {
        
        headerBgView = UIView(frame: CGRect.zero)
        headerBgView.translatesAutoresizingMaskIntoConstraints = false
        headerBgView.backgroundColor = .mainGreen
        view.addSubview(headerBgView)
        
        let logoImgView = UIImageView(image: UIImage(named: "cocoaheads_teammember"))
        logoImgView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImgView)
        logoImgView.align(attribute: .top, offset: ThemeManager.baseMargin)
        logoImgView.align(attribute: .left, offset: ThemeManager.baseMargin / 2)
        
        
        let headerLabel = BasicControls.basicLabel(fontSize: ThemeManager.baseFontSize * 1.2, bold: true)
        headerLabel.font = UIFont.boldSystemFont(ofSize: ThemeManager.baseFontSize * 1.5)
        headerLabel.text = "CocoaHeads Conference 2016"
        view.addSubview(headerLabel)
        headerLabel.align(attribute: .left, offset: logoImgView.bounds.width + ThemeManager.baseMargin)
        headerLabel.align(attribute: .right, offset: -ThemeManager.baseMargin)
        headerLabel.align(attribute: .top, offset: ThemeManager.baseMargin * 1.2)
        headerLabel.textColor = .breaktimeColor
        
        
        let statusInfoLabel = BasicControls.basicLabel(fontSize: ThemeManager.baseFontSize * 1.2, bold: true)
        statusInfoLabel.text = "Resultado da Avaliação"
        view.addSubview(statusInfoLabel)
        statusInfoLabel.align(attribute: .left, offset: logoImgView.bounds.width + ThemeManager.baseMargin)
        statusInfoLabel.align(attribute: .right, offset: -ThemeManager.baseMargin)
        statusInfoLabel.align(attribute: .top, withAttribute: .bottom, ofView: headerLabel, offset: ThemeManager.baseMargin)
        statusInfoLabel.textColor = .white

        currentUserInfo = BasicControls.basicLabel(fontSize: ThemeManager.baseFontSize, bold: true)
        currentUserInfo.translatesAutoresizingMaskIntoConstraints = false
        currentUserInfo.text = ""
        currentUserInfo.textColor = .white
        view.addSubview(currentUserInfo)
        currentUserInfo.align(attribute: .left, offset: logoImgView.bounds.width + ThemeManager.baseMargin)
        currentUserInfo.align(attribute: .right, offset: -ThemeManager.baseMargin)
        currentUserInfo.align(attribute: .top, withAttribute: .bottom, ofView: statusInfoLabel)
//
        headerBgView.align(attribute: .top, withAttribute: .top, ofView: view, offset: 0)
        headerBgView.align(attribute: .left, withAttribute: .left, ofView: view, offset: 0)
        headerBgView.align(attribute: .right, withAttribute: .right, ofView: view, offset: 0)
        headerBgView.align(attribute: .bottom, withAttribute: .bottom, ofView: currentUserInfo, offset: ThemeManager.baseMargin)
        
        logoImgView.align(attribute: .height, withAttribute: .height, ofView: headerBgView, offset: 0)
    }
    
    
    func updateUserFeedback() {
        
        currentUserInfo.text = user.email
        
        
        let cleanText = "Obrigado por participar do teste, \(user.name)!\n\nSeu resultado foi:\n\n \(user.score) pontos, correspondendo a \(Int(userRate))% de aproveitamento da avaliação. \n\n\nPara fechar o teste, \nbastar usar o botão \"Encerrar\"."
        
        let defaultAttributes:[String:AnyObject] = [NSFontAttributeName: endMessageLabel.font, NSForegroundColorAttributeName: UIColor.mainGreen]
        
        let specialAttributes:[String:AnyObject] = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: ThemeManager.baseFontSize * 2) , NSForegroundColorAttributeName: UIColor.breaktimeColor]
        
        let attrStr = NSMutableAttributedString(string: cleanText, attributes: defaultAttributes)
        
        attrStr.addAttributes(specialAttributes, range: cleanText.NS.range(of: user.name))
        attrStr.addAttributes(specialAttributes, range: cleanText.NS.range(of: "\(user.score)"))
        attrStr.addAttributes(specialAttributes, range: cleanText.NS.range(of: "\(Int(userRate))%"))
        
        endMessageLabel.attributedText = attrStr
        
        insertNewObject()
    }
    
    func finishTapped() {
        insertNewObject()
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    // CoreData deals
    
    func insertNewObject() {
        
        guard let context = self.managedObjectContext else { return }
        
        let entity = NSEntityDescription.entity(forEntityName: "UserData", in: context)
        
        let record = NSManagedObject(entity: entity!, insertInto: self.managedObjectContext)
        
        record.setValue(user.name, forKey: "name")
        record.setValue(user.email, forKey: "email")
        record.setValue(user.score, forKey: "score")
        record.setValue(userRate, forKey: "rate")
        
        do {
            // Save Record
            try record.managedObjectContext?.save()
            print("Saved!")
            
        } catch {
            let saveError = error as NSError
            print("\(saveError), \(saveError.userInfo)")
            
            // Show Alert View
            print("Your to-do could not be saved.")
        }
        
    }
    
}
