//
//  Medications.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 11.2.22..
//
//
import Foundation

class MedicationsService {
    
    public var medications : [Medication] = []
    public var archivedMedications : [Medication] = []
    public var activeMedications : [Medication] = []
    
    func getAllMedicationsList(user: User, completion: @escaping(Result<[Medication], AppointmentsError>) -> Void){
        completion(.success([Medication].init()))
    }
    
    func setActive(medication: Medication, completion: @escaping(Result<Bool, AppointmentsError>) -> Void ){
    }
    
    func setArchived(medication: Medication, completion: @escaping(Result<Bool, AppointmentsError>) -> Void ){
    }
    
    func changeMedication(old:Medication , new: Medication, completion: @escaping(Result<Bool, AppointmentsError>) -> Void){
    }
    
}
