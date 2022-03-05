//
//  ActiveMedicationsController.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 11.2.22..
//

import UIKit

class ActiveMedicationsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private var activeMedications: [Medication] = []
    var searchedMedication = [Medication]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = MedicationsService()
        activeMedications = service.getActiveMedications()
        tableView.reloadData()
        setNav()
       
        tableView.dataSource = self
        tableView.delegate = self
        
        self.searchBar.delegate = self
        let searchTextField = self.searchBar.searchTextField
        searchTextField.textColor = UIColor.black
        searchTextField.placeholder = "Search for name..."
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.backgroundColor = UIColor.systemGray5
        let glassIconView = searchTextField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedMedication = activeMedications.filter {
            $0.name.lowercased().prefix(searchText.count) == searchText.lowercased() || $0.name.lowercased().suffix(searchText.count) == searchText.lowercased()  }
        searching = true
        tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNav()
        let service = MedicationsService()
        activeMedications = service.getActiveMedications()
        if searching {
            searching = false
            searchBar.text = ""
            tableView.reloadData()
        }
        tableView.reloadData()
    }
    
    func setNav(){
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1) ]
        self.tabBarController?.tabBar.tintColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor =  UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1)
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedMedication.count
        } else {
            return activeMedications.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ActiveCell", for: indexPath)
        if searching {
            cell.textLabel?.text = searchedMedication[indexPath.row].name
        } else {
            cell.textLabel!.text = activeMedications[indexPath.row].name
            cell.detailTextLabel?.text = activeMedications[indexPath.row].consumption
        }
        cell.textLabel!.font =  UIFont.systemFont(ofSize: 20)
        
        cell.detailTextLabel?.numberOfLines = 0;
        cell.detailTextLabel?.lineBreakMode = .byWordWrapping
        cell.detailTextLabel?.font =  UIFont.systemFont(ofSize: 16)
        
        cell.imageView!.tintColor = UIColor.init(red: 51/255, green: 203/255, blue: 203/255, alpha: 1) 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMedication", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SelectedMedicationController {
            if searching {
                destination.medication = searchedMedication[(tableView.indexPathForSelectedRow?.row)!]
            } else {
            destination.medication = activeMedications[(tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
}
