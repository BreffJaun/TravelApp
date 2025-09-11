//
//  AuthView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import SwiftUI

struct AuthView: View {
    @StateObject private var authViewModel: AuthViewModel
    @StateObject private var weatherViewModel: WeatherViewModel
    @StateObject private var travelViewModel = TravelViewModel()
    
    init(useLocalRepository: Bool) {
        if useLocalRepository {
            _authViewModel = StateObject(
                wrappedValue: AuthViewModel(repository: LocalUserRepository())
            )
            
            _weatherViewModel = StateObject(
                wrappedValue: WeatherViewModel(repo: MockWeatherRepository())
            )
        } else {
            _authViewModel = StateObject(
                wrappedValue: AuthViewModel(repository: RemoteUserRepository())
            )
            _weatherViewModel = StateObject(
                wrappedValue: WeatherViewModel(repo: RemoteWeatherRepository())
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
                .environmentObject(weatherViewModel)
        }
    }
}

#Preview {
    AuthView(useLocalRepository: true)
}

//testuser@mail.com
//test123
