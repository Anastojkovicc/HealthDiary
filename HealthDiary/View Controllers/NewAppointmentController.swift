//
//  NewAppointmentController.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 21.1.22..
//

var medicationList: [Medication] = []

import UIKit

class NewAppointmentController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var newAppointmentLabel: UILabel!
    @IBOutlet weak var specialityInput: UITextField!
    @IBOutlet weak var dateInput: UITextField!
    @IBOutlet weak var noteInput: UITextView!
    @IBOutlet weak var addNewButton: UIButton!
    @IBOutlet weak var medicationLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        medicationList = []
        
        tableView.dataSource = self
        tableView.delegate = self
        
        noteInput.delegate = self
        noteInput.backgroundColor = UIColor.white
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dataChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateInput.inputView = datePicker
        dateInput.text = formatDate(date: Date())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpElements()
        reloadData()
    }
    
    @objc func dataChange(datePicker: UIDatePicker){
        dateInput.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM YYYY"
        return formatter.string(from: date)
    }
    
    func textFieldDidBeginEditing(_ dateTextField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dataChange(datePicker:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        dateTextField.inputView = datePicker
        dateTextField.text = formatDate(date: Date())

    }
    
    func closeDatePicker() {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeDatePicker()
    }
    
    func setUpElements(){
        newAppointmentLabel.font = UIFont.systemFont(ofSize: 20)
        newAppointmentLabel.textColor = UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1)
        
        noteLabel.font = UIFont.systemFont(ofSize: 16)
        noteLabel.textColor = UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1)
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1)]
        
        Utilities.styleTextField(specialityInput)
        Utilities.styleTextField(dateInput)
        Utilities.styleTextView(noteInput)
        
        addNewButton.layer.borderWidth = 2
        addNewButton.layer.borderColor = UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1).cgColor
        addNewButton.setTitleColor(UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1)  , for: UIControl.State.normal)
        addNewButton.tintColor = UIColor.init(red: 6/255, green: 162/255, blue: 155/255, alpha: 1)
        addNewButton.layer.cornerRadius = 5.0
        
        Utilities.styleFilledButton(saveButton)
        errorLabel.alpha = 0
    }
    
    func reloadData(){
        tableView.reloadData()
        if medicationList.isEmpty {
            medicationLabel.alpha = 0
        } else {
            medicationLabel.alpha = 1
            medicationLabel.font = UIFont.systemFont(ofSize: 18)
            tableView.reloadData()
            tableView.layer.borderWidth = 2
            tableView.layer.borderColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1).cgColor
            tableView.layer.cornerRadius = 5.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell", for: indexPath)
        
        cell.textLabel!.text = medicationList[indexPath.row].name
        cell.textLabel!.font =  UIFont.systemFont(ofSize: 18)
        
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        if medicationList[indexPath.row].archived {
            cell.detailTextLabel?.text = "archived"
            cell.detailTextLabel?.textColor = UIColor.gray
        } else {
            cell.detailTextLabel?.text = "active"
            cell.detailTextLabel?.textColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1)
        }
        cell.imageView!.tintColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1) 
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicationList.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        medicationList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        if ( medicationList.isEmpty ) {
            self.tableView.layer.borderWidth = 0
            self.tableView.layer.borderColor = UIColor.white.cgColor
            medicationLabel.alpha = 0
        }
    }
    
    func validateFields() -> String? {
        var errorMessage: Bool = false
        if specialityInput.text?.trimmingCharacters( in: .whitespacesAndNewlines) == ""
        {
            Utilities.styleErrorTextField(specialityInput)
            errorMessage = true
        } else {
            Utilities.styleTextField(specialityInput)
        }
        if dateInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Utilities.styleErrorTextField(dateInput)
            errorMessage = true
        } else {
            Utilities.styleTextField(dateInput)
        }
        if noteInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "Note:" || noteInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "N" || noteInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "No" || noteInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "Not" || noteInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "Note" || noteInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ":"  || noteInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            Utilities.styleErrorTextView(noteInput)
            errorMessage = true
        } else {
            Utilities.styleTextView(noteInput)
        }
        if errorMessage {
            return "Please fill in all fields."
        }
        return nil
    }
    
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.font = UIFont.systemFont(ofSize: 16)
        errorLabel.alpha = 1
    }
    
    @IBAction func onTapAdd(_ sender: Any) {
    }
    
    @IBAction func onTapSave(_ sender: Any) {
        let error =  validateFields()
        
        if error != nil {
            self.showError(error!)
        } else {
            let alert : UIAlertController = UIAlertController( title: "Save", message: "Do you really want to save this appointment?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { (myAlert) in
                
                let speciality =  self.specialityInput.text!.trimmingCharacters( in: .whitespacesAndNewlines)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy."
                let date: Date = dateFormatter.date(from: self.dateInput.text!.trimmingCharacters( in: .whitespacesAndNewlines))!
                
                let note = self.noteInput.text!.trimmingCharacters( in: .whitespacesAndNewlines)
                let medications : [Medication] = medicationList
                
                let newAppointment = Appointment.init(speciality: speciality, note: note, date: date, medicationList: medications)
                
                let service = NewAppointmentService()
                
                service.saveAppointment(appointment: newAppointment) { result in
                    switch result {
                    case .success(let saved):
                        if saved { print("Saved")
                            medicationList = []
                            self.navigationController?.popViewController(animated: true)
                        }
                        else { print("Saving error")}
                    case .failure(let loginError):
                        print(loginError.localizedDescription)
                        self.showError("")
                    }
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil ))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
