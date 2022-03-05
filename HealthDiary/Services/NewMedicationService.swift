//
//  NewMedicationService.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 2.2.22..
//

import Foundation

enum NewMedicationError: Error {
    case invalidParametars
}

class NewMedicationService {
    
    func saveMedication(medication: Medication, completion: @escaping(Result<Bool, NewMedicationError>) -> Void){
        medicationList.append(medication)
        
        completion(.success(true))

    }
}
