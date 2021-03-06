//
//  SelectedMedicationController.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 13.2.22..
//

import UIKit

class SelectedMedicationController: UIViewController {
    
    @IBOutlet weak var changeStatus: UIButton!
    @IBOutlet weak var medicationNameTextField: UITextField!
    @IBOutlet weak var consumptionTextView: UITextView!
    let service = MedicationsService()
    var medication: Medication!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        setNav()
        medicationNameTextField.text = medication?.name.capitalized
        if medication?.consumption == "" {
            consumptionTextView.alpha = 0
        } else {
            consumptionTextView.alpha = 1
            consumptionTextView.text = medication?.consumption
        }
        if medication.isArchived {
            changeStatus.setTitle("Activate", for: UIControl.State.normal)
        } else {
            changeStatus.setTitle("Archive", for: UIControl.State.normal)
        }
    }
    
    func setUpElements(){
        Utilities.styleNameTextField(medicationNameTextField)
        medicationNameTextField.isEnabled = false
        Utilities.styleDisabledTextView(consumptionTextView)
        consumptionTextView.isUserInteractionEnabled = false
        Utilities.styleFilledButton(changeStatus)
        changeStatus.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        changeStatus.isHidden = false
    }
    
    func setNav(){
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1) ]
        self.tabBarController?.tabBar.tintColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor =  UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1)
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1)
    }
    
    @IBAction func onTapChange(_ sender: Any) {
        var title: String?
        if medication.isArchived {
            title = "Activate"
        } else {
            title = "Archive"
        }
        let alert : UIAlertController = UIAlertController( title: title, message: "Do you really want to edit this medication?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { [self] (myAlert) in
            if self.medication.isArchived {
                self.service.setActive(medication: medication){ result in
                    switch result {
                    case .success:
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                self.service.setArchived(medication: medication){ result in
                    switch result {
                    case .success:
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil ))
        self.present(alert, animated: true, completion: nil)
    }
}
