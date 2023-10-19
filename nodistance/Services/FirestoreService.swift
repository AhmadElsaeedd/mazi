//
//  FirestoreService.swift
//  nodistance
//
//  Created by NYUAD on 17/10/2023.
//

import Foundation
import FirebaseFirestore
import CryptoKit

class FirestoreService {
    let db = Firestore.firestore()
    
    enum CustomError: Error {
        case groupNotFound
        case multipleGroupsFound
    }
    
    func create_group(email: String, uid: String) async throws -> String {
        let groupsRef = db.collection("groups")
        
        let generated_inv_code = try generate_inv_code(uid: uid)
        
        return try await withCheckedThrowingContinuation { continuation in
            let doc_ref = groupsRef.addDocument(data: ["created": FieldValue.serverTimestamp(), "owner": uid, "users": [uid], "owner_email": email, "invitations": [], "inv_code": generated_inv_code])
            doc_ref.getDocument { (document, err) in
                    if let err = err {
                        continuation.resume(throwing: err)
                    } else {
                        // return the id of the new document
                        continuation.resume(returning: doc_ref.documentID)
                    }
                }
            }
    }
    
    func create_user_doc(email: String, uid: String, group_id: String) async throws -> Bool {
        let users_ref = db.collection("users")

        return try await withCheckedThrowingContinuation { continuation in
            users_ref.document(uid).setData([
                "id" : uid,
                "email" : email,
                "groups" : [group_id],
                "joined" : FieldValue.serverTimestamp()
            ]) { err in
                if let err = err {
                    continuation.resume(throwing: err)
                } else {
                    continuation.resume(returning: true)
                }
            }
        }
    }

    
    func name_group(group_name: String, user_uid: String) async throws -> Bool {
        let query_snapshot = try await db.collection("groups").whereField("owner", isEqualTo: user_uid).getDocuments()
        
        guard query_snapshot.documents.count == 1 else {
            throw CustomError.multipleGroupsFound
        }

        guard let document = query_snapshot.documents.first else {
            throw CustomError.groupNotFound
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            document.reference.updateData(["group_name" : group_name]) { err in
                if let err = err {
                    continuation.resume(throwing: err)
                } else {
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func set_username(uid: String, username: String) async throws -> Bool {
        let query_snapshot = try await db.collection("users").whereField("id", isEqualTo: uid).getDocuments()
        
        guard query_snapshot.documents.count == 1 else {
            throw CustomError.multipleGroupsFound
        }

        guard let document = query_snapshot.documents.first else {
            throw CustomError.groupNotFound
        }
        
        return try await withCheckedThrowingContinuation{
            continuation in
            document.reference.updateData(["username" : username]) {
                err in
                if let err = err {
                    continuation.resume(throwing: err)
                } else {
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    func enter_group(uid: String, inv_code: String) async throws -> String {
        let query_snapshot = try await db.collection("groups").whereField("inv_code", isEqualTo: inv_code).getDocuments()

        guard query_snapshot.documents.count == 1 else {
            throw CustomError.multipleGroupsFound
        }

        guard let document = query_snapshot.documents.first else {
            throw CustomError.groupNotFound
        }
        
        let document_id = document.documentID

        return try await withCheckedThrowingContinuation { continuation in
            document.reference.updateData(["users" : FieldValue.arrayUnion([uid])]) { err in
                if let err = err {
                    continuation.resume(throwing: err)
                } else {
                    continuation.resume(returning: document_id)
                }
            }
        }
    }
    
    func generate_inv_code(uid: String) throws -> String {
        // Get current timestamp in milliseconds
        let timestamp = Date().timeIntervalSince1970 * 1000
        let combinedString = uid + "\(timestamp)"
        
        // Hash the combined string
        let hashedData = SHA256.hash(data: combinedString.data(using: .utf8)!)
        
        // Convert hash to string
        var hashString = hashedData.compactMap { String(format: "%02x", $0) }.joined()
        
        // Take a subset of the hash for a shorter code
        let startIndex = hashString.index(hashString.startIndex, offsetBy: 0)
        let endIndex = hashString.index(hashString.startIndex, offsetBy: 6)
        hashString = String(hashString[startIndex...endIndex])
        
        return hashString
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
