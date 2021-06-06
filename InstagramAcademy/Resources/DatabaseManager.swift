//
//  DatabaseManager.swift
//  InstagramAcademy
//
//  Created by Le Tong Minh Hieu on 5/1/21.
//

import Firebase

public class DatabaseManager  {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    //MARK: - Public
    
    //Check if username and email available
    // -Parameters
    // - email: String reprensting email
    // - username: String presenting username
    // - completion: Async callback for result if database entry succeed
    public func canCreateNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { (error, _) in
            if error == nil {
                //success
                completion(true)
                return
            } else {
                //failed
                completion(false)
                return
            }
        }
    }
    
    //MARK: -Private
}
