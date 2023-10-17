//
//  RegistrationView.swift
//  Purely
//
//  Created by Max Crutchfield on 10/14/23.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authObject: AuthenticationViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "tree.circle.fill")
                .resizable()
                .frame(width: 120, height: 120)
                .foregroundColor(.green)
                .padding(.top, 40)
            
            Text("Purely")
                .font(.title2)
                .fontWeight(.semibold)
            
            VStack(spacing: 24) {
                InputView(text: $email, title: "Email Address", placeHolder: "name@example.com")
                    .autocapitalization(.none)
                
                InputView(text: $fullName, title: "Full Name", placeHolder: "Full name")
                
                InputView(text: $password, title: "Password", placeHolder: "Enter your password", isSecureField: true)
                
                InputView(text: $confirmPassword, title: "Confirm Password", placeHolder: "Confirm password", isSecureField: true)
                
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button {
                Task {
                    try await authObject.createUser(withEmail: email, password: password, fullName: fullName)
                }
            }   label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                    
                }
                
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                
            }
            .background(Color(.systemBlue))
            .cornerRadius(10)
            .padding(.top, 24)
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3){
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
            
        }
        
    }
}

#Preview {
    RegistrationView()
}
