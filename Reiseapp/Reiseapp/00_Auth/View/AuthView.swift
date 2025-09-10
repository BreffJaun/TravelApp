//
//  AuthView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var authViewModel: AuthViewModel
    @StateObject private var travelViewModel = TravelViewModel()
    @StateObject private var addNewTripViewModel = AddNewTripViewModel()
    
    init(useLocalRepository: Bool) {
        if useLocalRepository {
            _authViewModel = StateObject(
                wrappedValue: AuthViewModel(repository: LocalUserRepository())
            )
        } else {
            _authViewModel = StateObject(
                wrappedValue: AuthViewModel(repository: RemoteUserRepository())
            )
        }
    }
    
    var body: some View {
//        if authViewModel.loggedInUser == nil {
        if false {
            LoginView()
                .environmentObject(authViewModel)
        } else {
            TabBarView()
                .environmentObject(authViewModel)
                .environmentObject(travelViewModel)
                .environmentObject(addNewTripViewModel)
        }
    }
}

#Preview {
    AuthView(useLocalRepository: true)
}

//testuser@mail.com
//test123
