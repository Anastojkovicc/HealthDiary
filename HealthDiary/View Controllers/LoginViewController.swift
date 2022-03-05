//
//  LoginViewController.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 17.1.22..
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
   
    public var loggedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
    func validateFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in both fields."
        }
        return nil
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let error =  validateFields()
        if error != nil {
            showError(error!)
        } else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password =  passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let service = LoginService()
            service.login(email: email, password: password) { result in
                switch result {
                case .success(let user):
                    if(user.password == password) {
                        print(user.email + " logged in ")
                        self.loggedUser = user
                        self.transitionToHome()
                    } else {
                        self.showError("Wrong password!")
                    }
                case .failure(let loginError):
                    print(loginError.localizedDescription)
                    self.showError("Wrong email or password!")
                }
            }
        }
    }
    
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        let tabsViewController = self.storyboard?.instantiateViewController(identifier: Constants.StoryBoard.tabsViewController) as? UITabBarController
        self.view.window?.rootViewController = tabsViewController
        self.view.window?.makeKeyAndVisible()
    }
}

