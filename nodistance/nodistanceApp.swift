//
//  nodistanceApp.swift
//  nodistance
//
//  Created by NYUAD on 16/10/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct nodistanceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var watchFunctionsViewModel = WatchFunctionsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
