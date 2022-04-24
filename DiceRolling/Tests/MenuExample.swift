//
//  MenuExample.swift
//  DiceRolling
//
//  Created by Andres camilo Raigoza misas on 24/04/22.
//

import SwiftUI

struct MenuExample: View {
    @State private var count = 0
    
    var body: some View {
        VStack {
            Menu("Actions") {
                Button("Duplicate", action: duplicate)
                Button("Rename", action: rename)
                Button("Delete…", action: delete)
                Menu("Copy") {
                    Button("Copy", action: copy)
                    Button("Copy Formatted", action: copyFormatted)
                    Button("Copy Library Path", action: copyPath)
                }
            }
            Text("Count: \(count)")
            Menu {
                Button("Open in Preview", action: openInPreview)
                Button("Save as PDF", action: saveAsPDF)
            } label: {
                Label("PDF", systemImage: "doc.fill")
            } primaryAction: {
                count += 1
            }
        }
    }
    
    func duplicate() { }
    func rename() { }
    func delete() { }
    func copy() { }
    func copyFormatted() { }
    func copyPath() { }
    func openInPreview() { }
    func saveAsPDF() { }
}

struct MenuExample_Previews: PreviewProvider {
    static var previews: some View {
        MenuExample()
    }
}
