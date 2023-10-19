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
    
    enum CustomError: Error {
            case emailInUse
            case invalidEmail
            case wrongPassword
            case userNotFound
            case unknownError
            case genericError
        }
    
    func create_user(email: String, password: String) async throws -> (email: String, uid: String) {
        return try await withCheckedThrowingContinuation { continuation in
            auth.createUser(withEmail: email, password: password) { result, error in
                if let error = error as NSError? {
                    switch error.code {
                    case 17007: // Firebase code for email already in use
                        continuation.resume(throwing: CustomError.emailInUse)
                    default:
                        continuation.resume(throwing: CustomError.genericError)
                    }
                } else if let uid = result?.user.uid {
                    continuation.resume(returning: (email: email, uid: uid))
                } else {
                    continuation.resume(throwing: CustomError.unknownError)
                }
            }
        }
    }
    
    //function that logs in with email and password
    func login_user(email: String, password: String) async throws -> (email: String, uid: String) {
            return try await withCheckedThrowingContinuation { continuation in
                auth.signIn(withEmail: email, password: password) { result, error in
                    if let error = error as NSError? {
                        switch error.code {
                        case 17008: // Firebase code for invalid email
                            continuation.resume(throwing: CustomError.invalidEmail)
                        case 17009: // Firebase code for wrong password
                            continuation.resume(throwing: CustomError.wrongPassword)
                        case 17011: // Firebase code for user not found
                            continuation.resume(throwing: CustomError.userNotFound)
                        default:
                            continuation.resume(throwing: CustomError.genericError)
                        }
                    } else if let uid = result?.user.uid {
                        continuation.resume(returning: (email: email, uid: uid))
                    } else {
                        continuation.resume(throwing: CustomError.unknownError)
                    }
                }
            }
        }
    
    func get_user_id() -> String? {
        return auth.currentUser?.uid
    }

}
