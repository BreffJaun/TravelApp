//
//  WeatherViewModel.swift
//  Reiseapp
//
//  Created by Oliver Bogumil on 08.09.25.
//

import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var info: WeatherInfo? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    let repo: WeatherRepository

    init(repo: WeatherRepository) {
        self.repo = repo
    }

    func loadWeather() async {
        let trimmed = city.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            errorMessage = "Bitte Stadt eingeben."
            return
        }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            info = try await repo.fetchWeather(for: trimmed)
        } catch {
            info = nil
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Preview-Helfer
    #if DEBUG
    static func previewLoaded() -> WeatherViewModel {
        let vm = WeatherViewModel(repo: MockWeatherRepository())
        vm.city = "Berlin"
        vm.info = WeatherInfo(city: "Berlin", temperature: 21.4, humidity: 58, windSpeed: 3.7, condition: .partlyCloudy)
        return vm
    }
    static func previewLoading() -> WeatherViewModel {
        let vm = WeatherViewModel(repo: MockWeatherRepository())
        vm.city = "Berlin"
        vm.isLoading = true
        return vm
    }
    static func previewError() -> WeatherViewModel {
        let vm = WeatherViewModel(repo: MockWeatherRepository())
        vm.city = "Berlin"
        vm.errorMessage = "Konnte Wetterdaten nicht laden."
        return vm
    }
    #endif
}

