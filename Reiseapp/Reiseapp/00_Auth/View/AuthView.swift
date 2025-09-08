//
//  AuthView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        if authViewModel.loggedInUser == nil {
            LoginView()
                .environmentObject(authViewModel)
        } else {
            TabBarView()
                .environmentObject(authViewModel)
        }
    }
}

#Preview {
    AuthView()
}
