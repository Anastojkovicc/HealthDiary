//
//  NewMedicationViewController.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 26.1.22..
//

import UIKit

class NewMedicationViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var newMedicationLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var consumptionTextView: UITextView!
    @IBOutlet weak var consumptionLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    let service = NewAppointmentService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements() {
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1)
        newMedicationLabel.font = UIFont.systemFont(ofSize: 20)
        newMedicationLabel.textColor = UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1)
        consumptionLabel.font = UIFont.systemFont(ofSize: 16)
        consumptionLabel.textColor = UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1)
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextView(consumptionTextView)
        Utilities.styleFilledButton(saveButton)
        errorLabel.alpha = 0
    }
    
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.font = UIFont.systemFont(ofSize: 16)
        errorLabel.alpha = 1
    }
    
    @IBAction func onTapSave(_ sender: Any) {
        if nameTextField.text?.trimmingCharacters( in: .whitespacesAndNewlines) == "" {
            nameTextField.layer.borderColor = UIColor.red.cgColor
            showError("Name of medication is required!")
        } else {
            let alert : UIAlertController = UIAlertController( title: "Add", message: "Do you really want to add this medication?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { (myAlert) in
                let name =  self.nameTextField.text!.trimmingCharacters( in: .whitespacesAndNewlines)
                let consumption = self.consumptionTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                let newMedication = NewMedication.init(name: name, consumption: consumption ?? "")
                medicationList.append(newMedication)
                self.navigationController?.popViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil ))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

