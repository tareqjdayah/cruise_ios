//
//  CartViewModel.swift
//  cruise
//
//  
//

import Foundation

class CartViewModel {
    let dbManager = DatabaseManager()

    func fetchCruiseList() -> [CruiseModel] {
        return dbManager.getAllCruiseModels()
    }
}

