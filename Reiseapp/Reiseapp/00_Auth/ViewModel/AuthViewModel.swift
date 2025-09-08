//
//  AuthViewModel.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var loggedInUser: User? = nil
    @Published var authError: AuthError?
    @Published var showPassword: Bool = false
    
    
    
    // Beispiel-User
    private var testUsers: [User] = dummyUsers
    
    var isLoginDisabled: Bool {
        email.isEmpty || password.isEmpty
    }
    
    func login() {
        guard isValidEmail(email) else {
            authError = .invalidEmail
            return
        }
        
        if let user = testUsers.first(where: { $0.email == email && $0.password == password }) {
            loggedInUser = user
            authError = nil
        } else {
            authError = .invalidCredentials
        }
    }
    
    func logout() {
        loggedInUser = nil
        email = ""
        password = ""
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^\S+@\S+\.\S+$"#
        return email.range(of: emailRegex, options: .regularExpression) != nil
    }
}
