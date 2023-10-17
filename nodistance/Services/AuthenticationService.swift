//
//  AuthenticationService.swift
//  nodistance
//
//  Created by NYUAD on 17/10/2023.
//

import Foundation
import FirebaseAuth

class AuthenticationService{
    let auth = Auth.auth()
    
    func create_user(email: String, password: String, completion: @escaping (Bool) -> Void){
        auth.createUser(withEmail: email, password: password) { result, error in
                    completion(error == nil)
                }
    }
    
}
