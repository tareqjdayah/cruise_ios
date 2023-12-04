//
//  PaymentViewModel.swift
//  cruise
//
//  
//

import Foundation

class PaymentViewModel {
    let dbManager = DatabaseManager()

    func saveCruiseModel(_ model: CruiseModel) {
        dbManager.saveCruiseModel(model)
    }
}
