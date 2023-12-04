

import Foundation

class SignUpViewModel {
    let dbManager = DatabaseManager()

    func saveData(name: String, email: String, password: String) -> Bool {
           dbManager.createTable()
           return dbManager.insert(name: name, email: email, password: password)
       }
}
