//
//  UsernameViewModel.swift
//  nodistance
//
//  Created by NYUAD on 18/10/2023.
//

import Foundation

class UsernameViewModel: ObservableObject {
    @Published var step: Int = 0
    @Published var username: String = ""
    @Published var fam_name: String = ""
    @Published var user_uid: String?
    
    private var authentication_service = AuthenticationService()
    private var firestore_service = FirestoreService()
    
    init() {
        get_current_user_uid()
    }
    
    enum CustomError : Error{
        case failedToRenameGroup
        case failed_to_update_username
    }
    
    func next_step(){
        step += 1
    }
    
    func first_step(){
        step = 0
    }
    
    func get_current_user_uid() {
        user_uid = authentication_service.get_user_id();
    }
    
    //another function that names the group
    func name_group() async throws {
        let success = try await firestore_service.name_group(group_name: fam_name, user_uid: user_uid!)
        if success {
            next_step()
        }
        else {
            throw CustomError.failedToRenameGroup
        }
    }
    
    //another function that adds the username to the group
    func add_user_name() async throws {
        let success = try await firestore_service.set_username(uid: user_uid!, username: username)
        if success {
            next_step()
        }
        else {
            throw CustomError.failed_to_update_username
        }
    }
}
