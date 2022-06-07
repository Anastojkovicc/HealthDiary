//
//  SignUpViewController.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 17.1.22..
//

import UIKit
import Foundation

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    let service = SignUpService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    
    func validateFields() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isEmailValid(cleanedEmail) == false {
            return "Please enter correct email format."
        }
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        let error =  validateFields()
        if error != nil {
            showError(error!)
        } else {
            let firstName =  firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email =  emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password =  passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let user = RegistrationData(firstName: firstName, lastName: lastName, email: email, password: password)
            
            self.service.signUp(registrationData: user) { result in
                switch result {
                case .success(let savedUser):
                    print(savedUser.firstName + " logged in ")
                    DataStorage.shared.loggedUser = savedUser
                    self.transitionToHome()
                case .failure(let savingError):
                    print(savingError.localizedDescription)
                    self.showError("Saving error!")
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
