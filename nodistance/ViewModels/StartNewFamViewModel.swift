//
//  StartNewFamViewModel.swift
//  nodistance
//
//  Created by NYUAD on 17/10/2023.
//

import Foundation

class StartNewFamViewModel: ObservableObject {
    @Published var step: Int8 = 0
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var yalla_navigate: Bool = false
    @Published var error_message: String?
    
    private var firestore_service = FirestoreService()
    private var authentication_service = AuthenticationService()
    
    func next_step(){
        step += 1
    }
    
    func first_step(){
        step = 0
    }
    
    func previous_step(){
        step -= 1
    }
    
    func start_group() async throws {
        if isValidEmail(email)
        {
            let user_info = try await authentication_service.create_user(email: email, password: password)
            if(user_info.email == email){
                let group_id = try await firestore_service.create_group(email: user_info.email, uid: user_info.uid)
                //check if group id exists
                if !group_id.isEmpty {
                    print("Group created successfully")
                    yalla_navigate = true
                    let success = try await firestore_service.create_user_doc(email: user_info.email, uid: user_info.uid, group_id: group_id)
                    if success {
                        print("created user document")
                    }
                    else {
                        print("failed to create user document")
                    }
                }
            }
            else{
                throw AuthenticationService.CustomError.emailInUse
            }
        }
        else{
            throw AuthenticationService.CustomError.invalidEmail
        }
    }
    
    //to check if the email is valid
    func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    func handle(error: Error) {
        switch error {
        case AuthenticationService.CustomError.emailInUse:
            error_message = "email address is already in use by another account."
        case AuthenticationService.CustomError.invalidEmail:
            error_message = "invalid email, please use a valid email address"
        default:
            // Handle other errors here or print the error
            print("Unhandled error: \(error)")
        }
    }
}
