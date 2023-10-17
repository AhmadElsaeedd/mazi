//
//  FirestoreService.swift
//  nodistance
//
//  Created by NYUAD on 17/10/2023.
//

import Foundation
import FirebaseFirestore

class FirestoreService {
    let db = Firestore.firestore()
    
    func create_group() async throws -> Bool {
        let groupsRef = db.collection("groups")
        
        return try await withCheckedThrowingContinuation { continuation in
            groupsRef.addDocument(data: ["created": FieldValue.serverTimestamp()]) { err in
                if let err = err {
                    continuation.resume(throwing: err)
                } else {
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func check_inv_code(_ inv_code: String) async throws -> Bool {
        return try await withCheckedThrowingContinuation {
            continuation in
            db.collection("groups").whereField("inv_code", isEqualTo: inv_code).getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                        continuation.resume(throwing: err)
                    } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                        continuation.resume(returning: true)
                    } else {
                        print("No group found with invite code: \(inv_code)")
                        continuation.resume(returning: false)
                    }
                }
        }
        
    }
}
