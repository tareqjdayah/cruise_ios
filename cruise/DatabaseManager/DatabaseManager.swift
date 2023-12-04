

import Foundation

import SQLite3

class DatabaseManager {
    var db: OpaquePointer?
    let dbName = "appDB.sqlite"
    
    init() {
        openDatabase()
    }
    
    func openDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbName)
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
    }
    
    func createTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS Users(
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        Name TEXT,
        Email TEXT,
        Password TEXT);
        """
        
        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Users table created.")
            } else {
                print("Users table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(name: String, email: String, password: String) -> Bool {
        let insertStatementString = "INSERT INTO Users (Name, Email, Password) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer?
        var success = false

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (password as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                success = true
            }
        }
        sqlite3_finalize(insertStatement)
        return success
    }

    
    func isUserRegistered(email: String, password: String) -> Bool {
        let queryStatementString = "SELECT * FROM Users WHERE Email = ? AND Password = ?;"
        var queryStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(queryStatement, 2, (password as NSString).utf8String, -1, nil)

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                sqlite3_finalize(queryStatement)
                return true
            }
        }

        sqlite3_finalize(queryStatement)
        return false
    }
    
    func getUserInfo(email: String, password: String) -> (isRegistered: Bool, name: String?) {
        let queryStatementString = "SELECT Name FROM Users WHERE Email = ? AND Password = ?;"
        var queryStatement: OpaquePointer?
        var name: String? = nil

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(queryStatement, 2, (password as NSString).utf8String, -1, nil)

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let queryResultCol1 = sqlite3_column_text(queryStatement, 0)
                name = String(cString: queryResultCol1!)
                sqlite3_finalize(queryStatement)
                return (true, name)
            }
        }

        sqlite3_finalize(queryStatement)
        return (false, nil)
    }
    
    func getUserDetails(email: String) -> (name: String, email: String)? {
        let queryStatementString = "SELECT Name, Email FROM Users WHERE Email = ?;"
        var queryStatement: OpaquePointer?

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (email as NSString).utf8String, -1, nil)

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let name = String(cString: sqlite3_column_text(queryStatement, 0))
                let email = String(cString: sqlite3_column_text(queryStatement, 1))
                sqlite3_finalize(queryStatement)
                return (name, email)
            }
        }

        sqlite3_finalize(queryStatement)
        return nil
    }

    func createCruiseTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS CruiseTable(
            Id INTEGER PRIMARY KEY AUTOINCREMENT,
            modelData TEXT);
        """

        var createTableStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("CruiseTable created.")
            } else {
                print("CruiseTable could not be created.")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("ERROR creating CruiseTable: \(errmsg)")
        }
        sqlite3_finalize(createTableStatement)
    }


    func saveCruiseModel(_ model: CruiseModel) {
        createCruiseTable()
        
        let insertStatementString = "INSERT INTO CruiseTable (modelData) VALUES (?);"
        var insertStatement: OpaquePointer?

        // Serialize the CruiseModel to JSON
        let encoder = JSONEncoder()
        guard let modelData = try? encoder.encode(model),
              let modelString = String(data: modelData, encoding: .utf8) else {
            print("Error serializing cruise model.")
            return
        }

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (modelString as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully saved cruise model.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("Could not save cruise model: \(errmsg)")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("INSERT statement could not be prepared: \(errmsg)")
        }

        sqlite3_finalize(insertStatement)
    }

    
    
    func getAllCruiseModels() -> [CruiseModel] {
           var cruises: [CruiseModel] = []
           let queryStatementString = "SELECT modelData FROM CruiseTable;" // Adjust to match your table structure
           var queryStatement: OpaquePointer?

           if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
               while sqlite3_step(queryStatement) == SQLITE_ROW {
                   if let queryResultCol1 = sqlite3_column_text(queryStatement, 0) {
                       let modelString = String(cString: queryResultCol1)
                       let decoder = JSONDecoder()
                       if let modelData = modelString.data(using: .utf8),
                          let cruise = try? decoder.decode(CruiseModel.self, from: modelData) {
                           cruises.append(cruise)
                       }
                   }
               }
           } else {
               print("SELECT statement could not be prepared")
           }

           sqlite3_finalize(queryStatement)
           return cruises
       }


}
