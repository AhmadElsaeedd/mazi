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
    func create_user(){
        print("creating user")
        if isValidEmail(email){
            authentication_service.create_user(email: email, password: password){ success in
                if success {
                    self.next_step()
                } else {
                    print("Error creating user")
                }
            }
        }
        else{
            print("Invalid email")
        }
    }
    
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
}
