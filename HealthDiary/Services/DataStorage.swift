//
//  DataStorage.swift
//  HealthDiary
//
//  Created by Ana Stojkovic on 5.3.22..
//

import Foundation

class DataStorage {
    var loggedUser: User?
    
    static let shared = DataStorage()
    
    private init(){}
}

