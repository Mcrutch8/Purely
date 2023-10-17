//
//  SearchView.swift
//  Purely
//
//  Created by Max Crutchfield on 10/17/23.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var authObject: AuthenticationViewModel
    var body: some View {
        Group {
            if authObject.userSession != nil {
                SearchView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    SearchView()
}
