//
//  FlightView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//
// 02_Flights/View/FlightView.swift
import SwiftUI

struct FlightView: View {
    @StateObject private var vm = FlightViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [ Color(red:0.65, green:0.85, blue:1.0),
                              Color(red:0.45, green:0.75, blue:0.95),
                              Color(red:0.60, green:0.55, blue:0.90) ],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                ).ignoresSafeArea()
                Rectangle().fill(.ultraThinMaterial).ignoresSafeArea()

                VStack(spacing: 14) {
                    Text("Günstigste Flüge").font(.title2).bold().foregroundStyle(.white)

                    Group {
                        ClearableTextField(placeholder: "Startort", text: $vm.startOrt)
                        ClearableTextField(placeholder: "Zielort", text: $vm.zielOrt)

                        DatePicker("", selection: $vm.abflugDatum, displayedComponents: .date).labelsHidden()
                    }
                    .padding(.horizontal)

                    Button { vm.suchen() } label: {
                        Label("Suchen", systemImage: "magnifyingglass").font(.body.weight(.semibold))
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 2)

                    Image("flugzeug")
                        .resizable().scaledToFit().frame(width: 120, height: 120).offset(y: -6)

                    if let msg = vm.errorMessage { Text(msg).foregroundStyle(.red).padding(.horizontal) }
                    if vm.isLoading { ProgressView("Suche läuft…").padding(.top, 8) }

                    if !vm.ergebnisse.isEmpty {
                        List(vm.ergebnisse) { f in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(f.from) → \(f.to)").font(.headline)
                                    Text(vm.dateText(f.date)).font(.subheadline).foregroundStyle(.secondary)
                                }
                                Spacer()
                                Text(vm.priceText(f.priceEUR)).font(.headline)
                            }.padding(.vertical, 4)
                        }
                        .frame(maxHeight: 240)
                    }

                    Spacer(minLength: 8)
                }
            }
        }
    }
}

#Preview { FlightView() }
