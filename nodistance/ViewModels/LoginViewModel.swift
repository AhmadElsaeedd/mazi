//
//  LoginViewModel.swift
//  nodistance
//
//  Created by NYUAD on 19/10/2023.
//

import Foundation

class LoginViewModel : ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    private var authentication_service = AuthenticationService()
    
    func login() async throws {
        let user_info = try await authentication_service.login_user(email: email,password: password)
        if (user_info.email == email) {
            print("user logged in")
        }
        else {
            print("failed to find user!")
        }
    }
}
