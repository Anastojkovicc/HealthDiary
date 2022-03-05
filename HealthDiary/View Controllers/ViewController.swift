//
//  ViewController.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 17.1.22..
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements(){
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
        
        if(self.navigationController != nil) {
            Utilities.styleNav(self.navigationController!)
        }
    }
    
}

