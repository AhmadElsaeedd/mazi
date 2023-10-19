//
//  InviteCodeViewModel.swift
//  nodistance
//
//  Created by NYUAD on 17/10/2023.
//

import Foundation

class InviteCodeViewModel : ObservableObject {
    @Published var step: Int8 = 0
    @Published var inv_code: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error_message: String?
    @Published var yalla_navigate: Bool = false
    
    private var authentication_service = AuthenticationService()
    private var firestore_service = FirestoreService()
    
    //check if invitation code is valid
    func check_inv_code() async {
        do{
            let success = try await firestore_service.check_inv_code(inv_code)
            if success {
                print("valid invitation code")
                self.next_step()
            }
            else{
                print("invalid inviation code")
            }
        }
        catch{
            
        }
    }
    
    //create user in authentication
    func create_user() async throws {
        print("creating user")
        if isValidEmail(email){
                let user_info = try await authentication_service.create_user(email: email, password: password)
                //check if user has actually been created
                if (user_info.email == email) {
                    //enter group here
                    let group_id = try await firestore_service.enter_group(uid: user_info.uid, inv_code: inv_code)
                    if !group_id.isEmpty {
                        yalla_navigate = true
                        let success = try await firestore_service.create_user_doc(email: user_info.email, uid: user_info.uid, group_id: group_id)
                        if success{
                            print("created user document")
                        }
                        else{
                            print("Failed to create user document")
                        }
                    }
                    else {
                        print("failed to join group")
                    }
                }else {
                    throw AuthenticationService.CustomError.emailInUse
                }
            }
        else{
            throw AuthenticationService.CustomError.invalidEmail
        }
    }
    
//    func check_email() async throws {
//        print("checking email")
//        let email_format_is_valid = isValidEmail(email)
//        if(!email_format_is_valid){
//            throw AuthenticationService.CustomError.invalidEmail
//        }
//        else{
//            let email_exists = try await authentication_service.check_email_exists(email: email)
//            if email_exists {
//                print("email existss")
//                throw AuthenticationService.CustomError.emailInUse
//            }
//            else {
//                print("email doesn't exist")
//                self.next_step()
//            }
//        }
//    }
    
    //to check if the email is valid
    func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    func next_step(){
        step += 1
    }
    
    func first_step(){
        step = 0
    }
    
    func previous_step(){
        step -= 1
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
