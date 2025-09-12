//
//  Untitled.swift
//  Reiseapp
//
//  Created by Mahbod Hamidi on 09.09.25.
//

import Foundation

@MainActor
final class FlightViewModel: ObservableObject {
    @Published var departureCity: String = ""
    @Published var destinationCity: String = ""
    @Published var departureDate: Date = Date()
    
    @Published var results: [Flight] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let repo: FlightRepository
    
    init(repo: FlightRepository) {
        self.repo = repo
    }
    
    func search() {
        errorMessage = nil
        let from = departureCity.trimmingCharacters(in: .whitespacesAndNewlines)
        let to = destinationCity.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !from.isEmpty else {
            errorMessage = "Bitte Startort eingeben."
            print("⚠️ Kein Startort angegeben")
            return
        }
        guard !to.isEmpty else {
            errorMessage = "Bitte Zielort eingeben."
            print("⚠️ Kein Zielort angegeben")
            return
        }
        guard from.lowercased() != to.lowercased() else {
            errorMessage = "Start und Ziel dürfen nicht gleich sein."
            print("⚠️ Start und Ziel sind gleich")
            return
        }
        
        isLoading = true
        results = []
        
        print("🔹 FlightViewModel search() called: \(from) → \(to) from \(departureDate)")
        
        Task {
            do {
                let fetched = try await repo.searchFlights(from: from, to: to, earliest: departureDate, returnDate: nil)
                
                if fetched.isEmpty {
                    errorMessage = "Keine Flüge gefunden."
                    print("⚠️ FlightViewModel: Keine Flüge aus Repository zurückgegeben")
                } else {
                    results = fetched
                    print("🔹 FlightViewModel: \(results.count) Flüge erhalten")
                    for (i, f) in results.enumerated() {
                        print("   ✈️ [\(i)] \(f.departure) → \(f.destination) am \(dateText(f.date)) für \(priceText(f.priceEUR))")
                    }
                }
            } catch FlightAPIError.invalidRequest {
                errorMessage = "Ungültige Anfrage. Bitte prüfe die Eingaben."
                print("⚠️ FlightViewModel: InvalidRequest Error")
            } catch {
                if let urlError = error as? URLError, urlError.code == .timedOut {
                    errorMessage = "Die Anfrage hat zu lange gedauert. Bitte überprüfe deine Internetverbindung."
                    print("⚠️ FlightViewModel: Timeout")
                } else {
                    errorMessage = "Fehler: \(error.localizedDescription)"
                    print("⚠️ FlightViewModel: Unbekannter Fehler: \(error)")
                }
            }
            isLoading = false
        }
    }
    
    func dateText(_ d: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: d)
    }
    
    func priceText(_ v: Double) -> String {
        String(format: "%.2f €", v)
    }
}
