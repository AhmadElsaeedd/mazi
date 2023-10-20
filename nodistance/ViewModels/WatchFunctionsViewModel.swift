//
//  WatchFunctionsViewModel.swift
//  nodistance
//
//  Created by NYUAD on 20/10/2023.
//

import Foundation
import WatchConnectivity

class WatchFunctionsViewModel: NSObject, WCSessionDelegate, ObservableObject {
    private var firestore_service = FirestoreService()
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("WCSession is inactive.")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("WCSession deactivated.")
    }
    
    
    var session: WCSession?
    
    override init() {
        print("I am here 2")
        super.init()
        session = WCSession.default
        session?.delegate = self
        session?.activate()
    }

    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("WCSession is active.")
            
        case .inactive:
            print("WCSession is inactive.")
            
        case .notActivated:
            print("WCSession is not activated.")
            
        @unknown default:
            print("Unknown WCSession activation state.")
        }

        if let error = error {
            print("WCSession activation failed with error: \(error.localizedDescription)")
        }
    }

    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("I AM TRIGGERED")
        // Handle received message from watchOS here
        if let action = message["action"] as? String, action == "addMessage" {
            print("HEY")
            // Call Firestore function here
            let success = firestore_service.add_message()/* Call your Firestore function and get result */
            if success {
                sendReplyToWatch(data: ["result": "success"])
            } else {
                sendReplyToWatch(data: ["result": "failure"])
            }
        }
    }
    
    func sendReplyToWatch(data: [String: Any]) {
        session?.sendMessage(data, replyHandler: nil, errorHandler: nil)
    }
}
