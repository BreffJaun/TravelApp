//
//  AuthError.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import Foundation

enum AuthError: LocalizedError {
    case invalidEmail
    case invalidCredentials
    case unknown(Error) 
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Bitte tragen Sie eine gültige E-Mail ein."
        case .invalidCredentials:
            return "Login fehlgeschlagen. Bitte überprüfen Sie die E-Mail oder das Passwort."
        case .unknown(let error):
            return "Ein unbekannter Fehler ist aufgetreten: \(error.localizedDescription)"
        }
    }
}
