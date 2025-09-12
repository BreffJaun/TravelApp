//
//  LoginView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("PrimaryGradientStart"),
                        Color("PrimaryGradientEnd")
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    
                    Image("LoginIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.bottom, 8)
                    
                    Text("Login")
                        .font(.largeTitle.bold())
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("E-Mail")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        ZStack(alignment: .trailing) {
                            TextField("E-Mail eingeben", text: $authViewModel.email)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .padding(12)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                )
                                .foregroundColor(.primary)
                            
                            if !authViewModel.email.isEmpty {
                                Button {
                                    authViewModel.email = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 8)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Passwort")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Group {
                                if authViewModel.showPassword {
                                    TextField("Passwort eingeben", text: $authViewModel.password)
                                } else {
                                    SecureField("Passwort eingeben", text: $authViewModel.password)
                                }
                            }
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .foregroundColor(.primary)
                            
                            // Clear-Button nur anzeigen, wenn Passwort nicht leer ist
                            if !authViewModel.password.isEmpty {
                                Button {
                                    authViewModel.password = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            // Passwort anzeigen/verbergen
                            Button {
                                authViewModel.showPassword.toggle()
                            } label: {
                                Image(systemName: authViewModel.showPassword ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal)
                    
                    
                    if let error = authViewModel.authError {
                        Text(error.localizedDescription)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    HStack(spacing: 12) {
                        Button {
                            authViewModel.login()
                        } label: {
                            Text("Login")
                                .frame(maxWidth: .infinity)
                        }
                        .disabled(authViewModel.isLoginDisabled)
                        .buttonStyle(.borderedProminent)
                        
                        Button {
                            // noch ohne Funktion
                        } label: {
                            Text("Registrieren")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.top, 32)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    LoginView()
}

