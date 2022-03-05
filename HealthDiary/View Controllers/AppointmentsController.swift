//
//  AppointmentsController.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 21.1.22..
//

import UIKit

class AppointmentsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newAppointmentButton: UIButton!
    @IBOutlet weak var sortNavItem: UIBarButtonItem!
    @IBOutlet weak var sortNameButton: UIBarButtonItem!
    @IBOutlet weak var sortByName: UIButton!
    @IBOutlet weak var sortByDate: UIButton!
    
    var sortDate : Bool = true
    var sortName : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        setNav()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNav()
        tableView.reloadData()
    }
    
    func setNav(){
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1) ]
        self.tabBarController?.tabBar.tintColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor =  UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1)
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1)
    }
    
    func setUpElements(){
        Utilities.styleSquaredButton(newAppointmentButton)
        self.navigationController?.navigationBar.scalesLargeContentImage = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //zameniti sa appointments
        return appointmentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy."
        //zameniti sa appointments
        let date = df.string(from: appointmentList[indexPath.row].date)
        
        cell.textLabel!.text = appointmentList[indexPath.row].speciality + " (" + date + ")"
        cell.textLabel!.font =  UIFont.systemFont(ofSize: 20)
        cell.detailTextLabel?.font =  UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.text = appointmentList[indexPath.row].note
        
        cell.imageView!.tintColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1) 
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    @IBAction func onTapNew(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SelectedAppointmentController {
            destination.appointment = appointmentList[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    @IBAction func onTapSortDate(_ sender: Any) {
        if sortDate {
                    sortDate = false
                    sortName = true
                    sortListDescending()
                } else {
                    sortDate = true
                    sortName = true
                    sortListAscending()
                }
    }
    
    func sortListAscending() {
        if(appointmentList.count > 1) {
            appointmentList = appointmentList.sorted(by: { $0.date.compare($1.date) == .orderedAscending})
            tableView.reloadData();
        }
    }
    
    func sortListDescending() {
        if(appointmentList.count > 1) {
            appointmentList = appointmentList.sorted(by: { $0.date.compare($1.date) == .orderedDescending})
            tableView.reloadData();
        }
    }

    @IBAction func onTapSortName(_ sender: Any) {
        if sortName{
            sortName = false
            sortDate = true
            sortListNamesDescending()
        } else {
            sortName = true
            sortDate = true
            sortListNamesAscending()
        }
    }
    
    func sortListNamesAscending() {
        if(appointmentList.count > 1) {
            appointmentList = appointmentList.sorted(by: { $0.speciality > $1.speciality } )
            tableView.reloadData();
        }
    }
    
    func sortListNamesDescending() {
        if(appointmentList.count > 1) {
            appointmentList = appointmentList.sorted(by: { $0.speciality < $1.speciality } )
            tableView.reloadData();
        }
    }
}
