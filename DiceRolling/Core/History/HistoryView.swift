//
//  HistoryView.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 24/04/22.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var vm: ViewModel
    @State private var showAlert = false
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                ForEach(vm.users, id: \.name) { user in
                    Section {
                        if let data1 = user.data[1] {
                            groupBoxData(user: user, numberOfDice: 1, data: data1)
                        }
                        if let data2 = user.data[2] {
                            groupBoxData(user: user, numberOfDice: 2, data: data2)
                        }
                        if let data3 = user.data[3] {
                            groupBoxData(user: user, numberOfDice: 3, data: data3)
                        }
                        if let data4 = user.data[4] {
                            groupBoxData(user: user, numberOfDice: 4, data: data4)
                        }
                        if user.data[1] == nil && user.data[2] == nil && user.data[3] == nil && user.data[4] == nil {
                            GroupBox {
                                Text("No data!")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    } header: {
                        Text(user.name)
                            .font(.title2.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 12)
                            .background(Color(uiColor: .systemBackground))
                    }
                }
                if vm.users.isEmpty {
                    Text("There's no users yet!")
                        .frame(maxWidth: .infinity)
                } else {
                    if vm.showClearHistoryButton {
                        GroupBox {
                            Button("Clear History", role: .destructive) {
                                showAlert = true
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .alert("Clear History", isPresented: $showAlert) {
                            Button("Cancel", role: .cancel) { }
                            Button("Delete", role: .destructive) {
                                vm.clearHistory()
                            }
                        } message: {
                            Text("Are you sure you want to clear the history data?")
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryView(vm: ViewModel())
        }
    }
}

extension HistoryView {
    private func groupBoxData(user: User, numberOfDice: Int, data: [Int]) -> some View {
        GroupBox {
            Divider()
            ForEach(data.indices, id: \.self) { index in
                Group {
                    Text("\(index + 1).  ")
                        .font(.headline)
                    +
                    Text(data[index] != 1 ? "\(data[index]) Points" : "\(data[index]) Point")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 5)
                Divider()
            }
            let total = data.reduce(0, +)
            Text(total != 1 ? "Total: \(total) Points" : "Total: \(total) Point")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
            
        } label: {
            Label("\(numberOfDice) Dice", systemImage: "dice")
        }
    }
}
