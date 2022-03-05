//
//  SelectedAppointmentController.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import UIKit

class SelectedAppointmentController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var specialityTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editAppointmentButton: UIBarButtonItem!
    @IBOutlet weak var medicationListLabel: UILabel!
    @IBOutlet weak var deleteAppointmentButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var appointment: Appointment!
    var editMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        specialityTextField.text = appointment?.speciality
        noteTextView.text = appointment?.note
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if editMode == false {
            setUpElements()
        } else {
            setEditMode()
        }
        
        dateTextField.delegate = self
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dataChange(datePicker:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTextField.inputView = datePicker
        dateTextField.text = formatDate(date: appointment?.date ?? Date())
        
        
    }
    
    func closeDatePicker() {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeDatePicker()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if editMode == false {
            setUpElements()
        } else {
            setEditMode()
        }
        
        let service = AppointmentsService()
        service.getAppointment(appointment: appointment) { result in
            switch result {
            case .success(let app):
                self.appointment = app
            case .failure(let appError):
                print(appError.localizedDescription)
            }
        }
        
        tableView.reloadData()
    }
    
    func setUpElements(){
        Utilities.styleDisabledTextField(specialityTextField)
        Utilities.styleDisabledTextField(dateTextField)
        Utilities.styleDisabledTextView(noteTextView)
        Utilities.styleFilledButton(deleteAppointmentButton)
        
        specialityTextField.isEnabled = false
        dateTextField.isEnabled = false
        noteTextView.isUserInteractionEnabled = false
        
        specialityTextField.textAlignment = NSTextAlignment.center
        dateTextField.textAlignment = NSTextAlignment.center
        deleteAppointmentButton.setTitle("Delete", for: UIControl.State.normal)
        editAppointmentButton.title = "Edit"
        editAppointmentButton.tintColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1)
        
        errorLabel.alpha = 0
        
        if appointment.medicationList.isEmpty {
            medicationListLabel.alpha = 0
        } else {
            medicationListLabel.alpha = 1
            medicationListLabel.font = UIFont.systemFont(ofSize: 18)
            tableView.reloadData()
            tableView.layer.borderWidth = 2
            tableView.layer.borderColor = UIColor.black.cgColor
            tableView.layer.cornerRadius = 5.0
        }
    }
    
    func setEditMode(){
        Utilities.styleTextField(specialityTextField)
        Utilities.styleTextField(dateTextField)
        Utilities.styleTextView(noteTextView)
        Utilities.styleFilledButton(deleteAppointmentButton)
        
        specialityTextField.isEnabled = true
        dateTextField.isEnabled = true
        noteTextView.isUserInteractionEnabled = true
        
        deleteAppointmentButton.setTitle("Save changes", for: UIControl.State.normal)
        editAppointmentButton.title = "Close"
        editAppointmentButton.tintColor = UIColor.black
        
        if appointment.medicationList.isEmpty {
            medicationListLabel.alpha = 0
        } else {
            medicationListLabel.alpha = 1
            medicationListLabel.font = UIFont.systemFont(ofSize: 18)
            tableView.reloadData()
            tableView.layer.borderWidth = 2
            tableView.layer.borderColor = UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1).cgColor
            tableView.layer.cornerRadius = 5.0
        }
    }
    
    @objc func dataChange(datePicker: UIDatePicker){
        dateTextField.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM YYYY"
        return formatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppMedicationCell", for: indexPath)
        
        cell.textLabel?.text = appointment?.medicationList[indexPath.row].name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        if appointment?.medicationList != nil {
            if appointment!.medicationList[indexPath.row].archived {
                cell.detailTextLabel?.text = "archived"
                cell.detailTextLabel?.textColor = UIColor.gray
            } else {
                cell.detailTextLabel?.text = "active"
                cell.detailTextLabel?.textColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1)
            }
        }
        cell.imageView!.tintColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1) 
        
        return  cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointment!.medicationList.count
    }
    
    @IBAction func onTapDelete(_ sender: Any) {
        if(editMode){
            let alert : UIAlertController = UIAlertController( title: "Save", message: "Do you really want to save changes?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (myAlert) in
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy."
                let date: Date = dateFormatter.date(from: self.dateTextField.text!.trimmingCharacters( in: .whitespacesAndNewlines))!
                
                let newApp: Appointment = Appointment.init(speciality: self.specialityTextField.text?.capitalized ?? "", note: self.noteTextView.text?.capitalized ?? "" , date: date , medicationList: self.appointment.medicationList)
                
                if self.specialityTextField.text != "" {
                    let service = AppointmentsService()
                    
                    service.changeAppointment(old: self.appointment, new: newApp ) { result in
                        switch result {
                        case .success(let saved):
                            if saved { print("Saved")
                                self.navigationController?.popViewController(animated: true)
                            }
                            else { print("Not saved")}
                        case .failure(let savingError):
                            print(savingError.localizedDescription)
                        }
                    }
                } else {
                    self.errorLabel.alpha = 1
                    self.errorLabel.text = "Speciality is required field!"
                }
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil ))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let alert : UIAlertController = UIAlertController( title: "Delete", message: "Do you really want to delete this appointment?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (myAlert) in
                
                let service = AppointmentsService()
                service.deleteAppointment(appointment: self.appointment) { result in
                    switch result {
                    case .success(let saved):
                        if saved { print("Deleted")
                            self.navigationController?.popViewController(animated: true)
                        }
                        else { print("Deleting error")}
                    case .failure(let deleteError):
                        print(deleteError.localizedDescription)
                    }
                }
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil ))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMedic", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SelectedMedicationController {
            destination.medication = appointment.medicationList[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    @IBAction func onTapEdit(_ sender: Any) {
        if editMode == false {
            editMode = true
            setEditMode()
        } else {
            let alert : UIAlertController = UIAlertController( title: "Close", message: "Do you really want to discard changes?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (myAlert) in
                
                self.specialityTextField.text = self.appointment?.speciality
                self.noteTextView.text = self.appointment?.note
                self.dateTextField.text = self.formatDate(date: self.appointment?.date ?? Date())
                
                self.editMode = false
                self.setUpElements()
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: nil ))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
