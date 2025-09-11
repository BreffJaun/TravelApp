//
//  FlightView.swift
//  Reiseapp
//
//  Created by Jeff Braun on 08.09.25.
//

import SwiftUI

struct FlightView: View {
    @StateObject private var vm = FlightViewModel()

    var body: some View {
        NavigationStack {
            GradientBackground {
                VStack(spacing: 14) {
                    Text("Günstigste Flüge")
                        .font(.title2).bold().foregroundStyle(.white)

                    Group {
                        TextField("Startort", text: $vm.startOrt)
                            .textFieldStyle(.roundedBorder)

                        TextField("Zielort", text: $vm.zielOrt)
                            .textFieldStyle(.roundedBorder)

                        DatePicker("", selection: $vm.abflugDatum, displayedComponents: .date)
                            .labelsHidden()
                    }
                    .padding(.horizontal)

                    Button {
                        vm.suchen()
                    } label: {
                        Label("Suchen", systemImage: "magnifyingglass")
                            .font(.body.weight(.semibold))
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 2)

                    Image("flugzeug")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .offset(y: -6)

                    if let msg = vm.errorMessage {
                        Text(msg).foregroundStyle(.red).padding(.horizontal)
                    }

                    if vm.isLoading {
                        ProgressView("Suche läuft…").padding(.top, 8)
                    }

                    if !vm.ergebnisse.isEmpty {
                        List(vm.ergebnisse) { f in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(f.from) → \(f.to)").font(.headline)
                                    Text(vm.dateText(f.date))
                                        .font(.subheadline).foregroundStyle(.secondary)
                                }
                                Spacer()
                                Text(vm.priceText(f.priceEUR)).font(.headline)
                            }
                            .padding(.vertical, 4)
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
