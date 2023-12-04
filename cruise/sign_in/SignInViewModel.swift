//
//  SignInViewModel.swift
//  cruise
//
//  Created by Mohammed Mansour on 01/12/2023.
//

import Foundation
class SignInViewModel {
    let dbManager = DatabaseManager()

    func checkUser(email: String, password: String) -> Bool {
        return dbManager.isUserRegistered(email: email, password: password)
    }
    

      func getUserInfo(email: String, password: String) -> (isRegistered: Bool, name: String?) {
          return dbManager.getUserInfo(email: email, password: password)
      }
}
