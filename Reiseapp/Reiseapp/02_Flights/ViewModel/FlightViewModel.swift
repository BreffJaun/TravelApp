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
    init(repo: FlightSearchRepository = FakeFlightSearchRepository()) { self.repo = repo }

    
    
    func suchen() {
        errorMessage = nil
        let from = startOrt.trimmingCharacters(in: .whitespacesAndNewlines)
        let to   = zielOrt.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !from.isEmpty else { errorMessage = "Bitte Startort eingeben."; return }
        guard !to.isEmpty   else { errorMessage = "Bitte Zielort eingeben.";  return }
        guard from.lowercased() != to.lowercased() else {
            errorMessage = "Start und Ziel dürfen nicht gleich sein."; return
        }
        
        isLoading = true; ergebnisse = []
        Task {
            do { ergebnisse = try await repo.search(from: from, to: to, earliest: abflugDatum) }
            catch { errorMessage = (error as? LocalizedError)?.errorDescription ?? "Suche fehlgeschlagen." }
            isLoading = false
        }
    }

    func dateText(_ d: Date) -> String { let f = DateFormatter(); f.dateStyle = .medium; return f.string(from: d) }
    func priceText(_ v: Double) -> String { String(format: "%.2f €", v) }
}
