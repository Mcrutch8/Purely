//
//  AuthenticationViewModel.swift
//  Purely
//
//  Created by Max Crutchfield on 10/17/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthenticationViewModel: ObservableObject {
    
    // This variable will tell us if we have a user logged in so we can determin to route user to login or straight into app
    @Published var userSession: FirebaseAuth.User?
    
    @Published var currentUser: User?
    
    init() {
        
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        print("sign in")
    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws {
        do {
            
            // try to create a user with Firebase code
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            // if we get a good result then we set our user session property
            self.userSession = result.user
            
            // create our user object and encode it and upload it to FireStore
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("DEBUG: FAILED to create user with error \(error.localizedDescription)")
        }
        
    }
    
    func signOut() {
        
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        
    }
}
