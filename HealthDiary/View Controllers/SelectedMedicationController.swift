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
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var editMode: Bool = false
    
    var medication: Medication!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if editMode == false {
            setUpElements()
        } else {
            setEditMode()
        }
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
        Utilities.styleFilledButton(saveChangesButton)
        saveChangesButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        saveChangesButton.isHidden = true
        changeStatus.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        editButton.title = "Edit"
        editButton.tintColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1)
        
        changeStatus.isHidden = false
        errorLabel.alpha = 0
    }
    
    func setEditMode(){
        Utilities.styleTextView(consumptionTextView)
        consumptionTextView.isUserInteractionEnabled = true
        Utilities.styleTextField(medicationNameTextField)
        medicationNameTextField.isEnabled = true
        saveChangesButton.isHidden = false
        
        changeStatus.isHidden = true
        editButton.title = "Close"
        editButton.tintColor = UIColor.black
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
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (myAlert) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil ))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func onTapEdit(_ sender: Any) {
        if editMode == false {
            editMode = true
            setEditMode()
        } else {
            let alert : UIAlertController = UIAlertController( title: "Close", message: "Do you really want to discard changes?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (myAlert) in
                self.navigationController?.popViewController(animated: true)
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil ))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func onTapSave(_ sender: Any) {
        let alert : UIAlertController = UIAlertController( title: "Save", message: "Do you really want to save changes?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (myAlert) in
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil ))
        self.present(alert, animated: true, completion: nil)
    }
}
