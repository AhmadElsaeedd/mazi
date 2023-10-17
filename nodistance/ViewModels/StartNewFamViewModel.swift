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
    
    private var firestore_service = FirestoreService()
    
    func next_step(){
        step += 1
    }
    
    func first_step(){
        step = 0
    }
    
    func start_group() async {
        do{
            let success = try await firestore_service.create_group()
            if success{
                print("Group created successfully")
            }
        }
        catch{
            
        }
    }
}
