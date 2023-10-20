//
//  MainButtonsViewModel.swift
//  mazi-fam Watch App
//
//  Created by NYUAD on 20/10/2023.
//

import Foundation
import WatchKit
import WatchConnectivity

class MainButtonsViewModel: NSObject, WCSessionDelegate, ObservableObject {

    var session: WCSession?
    
    override init() {
        print("I am here")
        super.init()
        session = WCSession.default
        session?.delegate = self
        session?.activate()
    }


    func button_click() {
        print("button click")
        sendMessageToPhone(action: "addMessage")
    }
    
    func sendMessageToPhone(action: String) {
        print("I am here dawg")
        if session?.isReachable ?? false {
            print("reachable")
            session?.sendMessage(["action": action], replyHandler: { response in
                if let result = response["result"] as? String {
                    DispatchQueue.main.async {
                        if result == "success" {
                            print("Successful function call")
                        } else {
                            print("Unsuccessful")
                        }
                    }
                }
            }, errorHandler: { error in
                print("fuck off")
            })
        } else {
            print("iPhone is not reachable.")
        }
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
}
