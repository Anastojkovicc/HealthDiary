//
//  Medications.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 11.2.22..
//
//
import Foundation

enum MedicationsError: Error {
    case invalidParametars
}


class MedicationsService {
    
    public var medications : [Medication] = []
    public var archivedMedications : [Medication] = []
    public var activeMedications : [Medication] = []
    
    func getAllMedications() -> [Medication] {
        for app in appointmentList{
            if !app.medicationList.isEmpty {
                medications += app.medicationList
            }
        }
        
        return medications
    }
    
    func getArchivedMedications() -> [Medication] {
        for app in appointmentList{
            if app.medicationList.isEmpty == false {
                for med in app.medicationList {
                    if med.archived == true {
                        archivedMedications.append(med)
                    }
                    
                }
            }
        }
        return archivedMedications
    }
    
    func getActiveMedications() -> [Medication] {
        for app in appointmentList{
            if !app.medicationList.isEmpty {
                for med in app.medicationList {
                    if med.archived == false {
                        activeMedications.append(med)
                    }
                    
                }
            }
        }
        return activeMedications
    }
    
    func getAllMedicationsList(user: User, completion: @escaping(Result<[Medication], AppointmentsError>) -> Void){
        completion(.success([Medication].init()))
    }
    
    func setActive(medication: Medication, completion: @escaping(Result<Bool, AppointmentsError>) -> Void ){
        var indexApp: Int!
        var indexMed: Int!
        
        for (indexA, elementA) in appointmentList.enumerated() {
            for (indexM, elementM) in elementA.medicationList.enumerated() {
                if elementM.name == medication.name && elementM.consumption.capitalized == medication.consumption.capitalized {
                    indexApp = indexA
                    indexMed = indexM
                }
            }
        }
        if indexApp != nil && indexMed != nil {
            appointmentList[indexApp].medicationList[indexMed].Active()
            completion(.success(true))
        } else {
            completion(.success(false))
        }
    }
    
    func setArchived(medication: Medication, completion: @escaping(Result<Bool, AppointmentsError>) -> Void ){
        var indexApp: Int!
        var indexMed: Int!
        
        for (indexA, elementA) in appointmentList.enumerated() {
            for (indexM, elementM) in elementA.medicationList.enumerated() {
                if elementM.name == medication.name && elementM.consumption.capitalized == medication.consumption.capitalized {
                    indexApp = indexA
                    indexMed = indexM
                }
            }
        }
        if indexApp != nil && indexMed != nil {
            appointmentList[indexApp].medicationList[indexMed].Archived()
            completion(.success(true))
        } else {
            completion(.success(false))
        }
    }
    
    func changeMedication(old:Medication , new: Medication, completion: @escaping(Result<Bool, AppointmentsError>) -> Void){
        var indexApp: Int!
        var indexMed: Int!
        
        for (indexA, elementA) in appointmentList.enumerated() {
            for (indexM, elementM) in elementA.medicationList.enumerated() {
                if elementM.name == old.name && elementM.consumption.capitalized == old.consumption.capitalized {
                    indexApp = indexA
                    indexMed = indexM
                }
            }
        }
        if indexApp != nil && indexMed != nil {
            appointmentList[indexApp].medicationList[indexMed] = new
            completion(.success(true))
        } else {
            completion(.success(false))
        }
    }
    
}
