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
//    @Published var loggedInUser: User? = dummyUsers[2]
    @Published var loggedInUser: User? = nil
    @Published var authError: AuthError?
    @Published var showPassword: Bool = false
    
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    var isLoginDisabled: Bool {
        email.isEmpty || password.isEmpty
    }
    
    func login() {
        guard isValidEmail(email) else {
            authError = .invalidEmail
            return
        }
        
        Task {
            do {
                let user = try await repository.login(email: email, password: password)
                loggedInUser = user
                authError = nil
            } catch let error as AuthError {
                authError = error
            } catch {
                authError = .unknown(error)
            }
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
