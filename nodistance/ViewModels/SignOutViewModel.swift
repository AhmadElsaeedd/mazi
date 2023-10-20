//
//  SignOutViewModel.swift
//  nodistance
//
//  Created by NYUAD on 20/10/2023.
//

import Foundation

class SignOutVIewModel : ObservableObject{
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var yalla_navigate: Bool = false
    @Published var error_message: String?
    
    private var authentication_service = AuthenticationService()
    
    func sign_out() async throws{
        //auth service sign out function
        let success = try await authentication_service.logout()
        if success{
            print("signout successful")
            yalla_navigate = true
        }
        else{
            throw AuthenticationService.CustomError.genericError
        }
    }
    
    func handle(error: Error) {
        switch error {
        case AuthenticationService.CustomError.genericError:
            error_message = "couldn't logout"
        default:
            // Handle other errors here or print the error
            print("Unhandled error: \(error)")
        }
    }
}
