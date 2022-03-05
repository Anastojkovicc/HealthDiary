//
//  Utilities.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 17.1.22..
//

import UIKit
import Foundation 

class Utilities {
    
    static func styleTextField(_ textField: UITextField){
        let bottomLine = CALayer()
        bottomLine.frame =  CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor =  UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1).cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
    
    static func styleNameTextField(_ textField: UITextField){
        let bottomLine = CALayer()
        bottomLine.frame =  CGRect(x: 0, y: textField.frame.height - 2, width: 0, height: 2)
        bottomLine.backgroundColor =  UIColor.black.cgColor
        textField.borderStyle = .none
        textField.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        textField.layer.addSublayer(bottomLine)
    }
    
    static func styleTextView(_ textView: UITextView){
        textView.layer.borderColor = UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1).cgColor
        textView.layer.borderWidth = 2.0;
        textView.layer.cornerRadius = 5.0;
    }
    
    static func styleErrorTextView(_ textView: UITextView){
        textView.layer.borderColor = UIColor.red.cgColor
        textView.layer.borderWidth = 2.0;
        textView.layer.cornerRadius = 5.0;
    }
    
    static func styleDisabledTextField(_ textField: UITextField){
        let bottomLine = CALayer()
        bottomLine.frame =  CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor =  UIColor.black.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
    
    static func styleDisabledTextView(_ textView: UITextView){
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 2.0;
        textView.layer.cornerRadius = 5.0;
    }
    
    static func styleErrorTextField(_ textField: UITextField){
        let bottomLine = CALayer()
        bottomLine.frame =  CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor =  UIColor.red.cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton(_ button:UIButton){
        button.backgroundColor = UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton){
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func styleBackButton(_ button:UIButton){
        button.setTitleColor(UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1) , for: UIControl.State.normal)
        button.tintColor = UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1)
    }
    
    static func styleSquaredButton(_ button:UIButton){
        button.backgroundColor =  UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1)
        button.titleLabel!.font =  UIFont.systemFont(ofSize: 20)
        button.layer.cornerRadius = 5.0
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.tintColor = UIColor.white
    }
    
    
    static func isEmailValid(_ enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func styleNav(_ navContoller : UINavigationController) {
        navContoller.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navContoller.navigationBar.shadowImage = UIImage()
        navContoller.navigationBar.isTranslucent = true
        navContoller.view.backgroundColor = .clear
        navContoller.navigationBar.tintColor = UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1)
        navContoller.navigationBar.backItem?.backBarButtonItem?.tintColor = UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1)
    }
}
