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
    @StateObject private var flightViewModel: FlightViewModel
    @StateObject private var travelViewModel = TravelViewModel()
    
    init(useLocalRepository: Bool) {
        if useLocalRepository {
            print("🟢 AuthView: Verwende LOCAL Repositories")
            _authViewModel = StateObject(
                wrappedValue: AuthViewModel(repository: LocalUserRepository())
            )
            
            _weatherViewModel = StateObject(
                wrappedValue: WeatherViewModel(repo: MockWeatherRepository())
            )
            
            _flightViewModel = StateObject(
                wrappedValue: FlightViewModel(repo: LocalFlightRepository())
            )
        } else {
            print("🌐 AuthView: Verwende REMOTE Repositories (FlightAPI)")
            _authViewModel = StateObject(
                wrappedValue: AuthViewModel(repository: RemoteUserRepository())
            )

            _weatherViewModel = StateObject(
                wrappedValue: WeatherViewModel(repo: RemoteWeatherRepository())
            )
            
            _flightViewModel = StateObject(
                wrappedValue: FlightViewModel(repo: RemoteFlightRepository())
            )
        }
    }
    
    var body: some View {
        if authViewModel.loggedInUser == nil {
//        if false {
            LoginView()
                .environmentObject(authViewModel)
        } else {
            TabBarView()
                .environmentObject(authViewModel)
                .environmentObject(travelViewModel)
                .environmentObject(weatherViewModel)
                .environmentObject(flightViewModel)
        }
    }
}

#Preview {
    AuthView(useLocalRepository: true)
}

//testuser@mail.com
//test123
