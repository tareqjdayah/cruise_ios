//
//  ProfileViewModel.swift
//  cruise
//
// 
//

import Foundation

class ProfileViewModel {
    let dbManager = DatabaseManager()

    func fetchUserDetails(email: String) -> (name: String, email: String)? {
        return dbManager.getUserDetails(email: email)
    }
}
