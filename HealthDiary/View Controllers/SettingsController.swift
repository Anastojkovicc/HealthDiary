//
//  SettingsController.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 18.2.22..
//

import UIKit

class SettingsController: UIViewController {
    
    @IBOutlet weak var logOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements(){
        Utilities.styleSquaredButton(logOutButton)
    }
    
    func transitionToHome(){
        let startViewController = self.storyboard?.instantiateViewController(identifier: Constants.StoryBoard.startViewController) as? ViewController
        self.view.window?.rootViewController = startViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func onTapLogOut(_ sender: Any) {
        let alert : UIAlertController = UIAlertController( title: "Log out", message: "Do you really want to log out?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (myAlert) in
            DataStorage.shared.loggedUser = nil
            self.transitionToHome()
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil ))
        self.present(alert, animated: true, completion: nil)
    }
}
