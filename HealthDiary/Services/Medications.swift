//
//  Medications.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 11.2.22..
//
//
import Foundation
import Alamofire

class MedicationsService {
    
    public var medications : [Medication] = []
    public var archivedMedications : [Medication] = []
    public var activeMedications : [Medication] = []
    
    func getAllMedicationsList(user: User, completion: @escaping(Result<[Medication], AppointmentsError>) -> Void){
        let request = RequestFactory.makeRequest(method: .get,
                                                 path: "/medications",
                                                 queryItems: [
                                                    URLQueryItem(name: "userId", value: "\(user.id)")
                                                 ])
                                                 
            AF.request(request).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    do {
                        let medicationList = try JSONDecoder().decode([MedicationDTO].self, from: data)
                        var medications : [Medication] = []
                        for medication in medicationList{
                            let newMedication = Medication.init(id: medication.id, name: medication.name, consumption: medication.consumption, isArchived: medication.isArchived)
                            medications.append(newMedication)
                        }
                        completion(.success(medications))
                    } catch {
                        completion(.failure(.invalidParametars))
                    }
                case .failure(let error):
                    debugPrint(error)
                    completion(.failure(.invalidParametars))
                }
            }).cURLDescription(calling: { description in
                print(description)
            })
        
    }
    
    func getActiveMedications(user: User, completion: @escaping(Result<[Medication], AppointmentsError>) -> Void){
        let request = RequestFactory.makeRequest(method: .get,
                                                 path: "/medications",
                                                 queryItems: [
                                                    URLQueryItem(name: "userId", value: "\(user.id)"),
                                                    URLQueryItem(name: "isArchived", value: "false")
                                                 ])
                                                 
            AF.request(request).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    do {
                        let medicationList = try JSONDecoder().decode([MedicationDTO].self, from: data)
                        var medications : [Medication] = []
                        for medication in medicationList{
                            let newMedication = Medication.init(id: medication.id, name: medication.name, consumption: medication.consumption, isArchived: medication.isArchived)
                            medications.append(newMedication)
                        }
                        completion(.success(medications))
                    } catch {
                        completion(.failure(.invalidParametars))
                    }
                case .failure(let error):
                    debugPrint(error)
                    completion(.failure(.invalidParametars))
                }
            }).cURLDescription(calling: { description in
                print(description)
            })
    }
    
    func getArchivedMedications(user: User, completion: @escaping(Result<[Medication], AppointmentsError>) -> Void){
        let request = RequestFactory.makeRequest(method: .get,
                                                 path: "/medications",
                                                 queryItems: [
                                                    URLQueryItem(name: "userId", value: "\(user.id)"),
                                                    URLQueryItem(name: "isArchived", value: "true")
                                                 ])
                                                 
            AF.request(request).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    do {
                        let medicationList = try JSONDecoder().decode([MedicationDTO].self, from: data)
                        var medications : [Medication] = []
                        for medication in medicationList{
                            let newMedication = Medication.init(id: medication.id, name: medication.name, consumption: medication.consumption, isArchived: medication.isArchived)
                            medications.append(newMedication)
                        }
                        completion(.success(medications))
                    } catch {
                        completion(.failure(.invalidParametars))
                    }
                case .failure(let error):
                    debugPrint(error)
                    completion(.failure(.invalidParametars))
                }
            }).cURLDescription(calling: { description in
                print(description)
            })
    }
    
    func setActive(medication: Medication, completion: @escaping(Result<Void, AppointmentsError>) -> Void ){
        let request = RequestFactory.makeRequest(method: .put,
                                                 path: "/medications/\(medication.id)",
                                                 queryItems: [
                                                    URLQueryItem(name: "isArchived", value: "false")
                                                 ])
                                                 
            AF.request(request).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    completion(.success(()))
                case .failure(let error):
                    debugPrint(error)
                    completion(.failure(.invalidParametars))
                }
            }).cURLDescription(calling: { description in
                print(description)
            })
    }
    
    func setArchived(medication: Medication, completion: @escaping(Result<Void, AppointmentsError>) -> Void ){
        let request = RequestFactory.makeRequest(method: .put,
                                                 path: "/medications/\(medication.id)",
                                                 queryItems: [
                                                    URLQueryItem(name: "isArchived", value: "true")
                                                 ])
                                                 
            AF.request(request).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    completion(.success(()))
                case .failure(let error):
                    debugPrint(error)
                    completion(.failure(.invalidParametars))
                }
            }).cURLDescription(calling: { description in
                print(description)
            })
    }
    
    func changeMedication(old:Medication , new: Medication, completion: @escaping(Result<Bool, AppointmentsError>) -> Void){
    }
    
}
