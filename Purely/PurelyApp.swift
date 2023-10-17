//
//  PurelyApp.swift
//  Purely
//
//  Created by Max Crutchfield on 10/13/23.
//

import SwiftUI
import Firebase

@main
struct PurelyApp: App {
    @StateObject var authObject = AuthenticationViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SearchView()
                .environmentObject(authObject)
        }
    }
}
