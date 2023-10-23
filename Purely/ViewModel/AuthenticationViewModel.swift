//
//  AuthenticationViewModel.swift
//  Purely
//
//  Created by Max Crutchfield on 10/17/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class AuthenticationViewModel: ObservableObject {
    
    // This variable will tell us if we have a user logged in so we can determin to route user to login or straight into app
    @Published var userSession: FirebaseAuth.User?
    
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            // Try to fetch user data immediatly
            await fetchUser()
        }
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
            
            // Upload user info to Firestore database
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser() 
        } catch {
            print("DEBUG: FAILED to create user with error \(error.localizedDescription)")
        }
        
    }
    
    func signOut() {
        
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        
        // Get the current users information from Firebase
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("DEBUG: current user is \(self.currentUser)")
    }
}
