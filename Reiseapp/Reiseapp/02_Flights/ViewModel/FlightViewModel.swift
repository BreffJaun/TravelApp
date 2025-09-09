//
//  Untitled.swift
//  Reiseapp
//
//  Created by Mahbod Hamidi on 09.09.25.
//

import Foundation

@MainActor
final class FlightViewModel: ObservableObject {

   
    @Published var startOrt: String = ""
    @Published var zielOrt: String = ""
    @Published var abflugDatum: Date = Date()

   
    @Published var ergebnisse: [Flight] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repo: FlightSearchRepository

    init(repo: FlightSearchRepository = FakeFlightSearchRepository()) {
        self.repo = repo
    }

    func suchen() {
        errorMessage = nil

    
        let from = startOrt.trimmingCharacters(in: .whitespacesAndNewlines)
        let to   = zielOrt.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !from.isEmpty else { errorMessage = "Bitte Startort eingeben."; return }
        guard !to.isEmpty   else { errorMessage = "Bitte Zielort eingeben.";  return }
        guard from.lowercased() != to.lowercased() else {
            errorMessage = "Start und Ziel dürfen nicht gleich sein."
            return
        }

        isLoading = true
        ergebnisse = []

        Task {
            do {
                let result = try await repo.search(from: from, to: to, earliest: abflugDatum)
                self.ergebnisse = result
            } catch {
                self.errorMessage = (error as? LocalizedError)?.errorDescription ?? "Suche fehlgeschlagen."
            }
            self.isLoading = false
        }
    }


    func dateText(_ date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df.string(from: date)
    }

    func priceText(_ eur: Double) -> String {
        String(format: "%.2f €", eur)
    }
}
