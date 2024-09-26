//
//  ListViewButtons.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 20/09/2024.
//

import SwiftUI

enum ListViewButtonsModes {
    case Room
    case Object
    case RoomConnection
}

struct ListViewButtons: View {
    var mode: ListViewButtonsModes
    var addAction : () -> Void
    var deleteAction: () -> Void
    
    @State private var isAlertPresented: Bool
    let alertTitle: String
    let alertMessage: String
    
    init(mode: ListViewButtonsModes, addAction: @escaping () -> Void, deleteAction: @escaping () -> Void) {
        self.mode = mode
        self.addAction = addAction
        self.deleteAction = deleteAction
        self.isAlertPresented = false
        
        switch mode {
        case .Object: do {
                self.alertTitle = "Deleting Object"
                self.alertMessage = "Are you sure you want to delete this Object?"
            }
            
        case .Room: do {
                self.alertTitle = "Deleting Room"
                self.alertMessage = "Are you sure you want to delete this Room?"
            }
            
        case .RoomConnection: do {
                self.alertTitle = "Deleting Connection"
                self.alertMessage = "Are you sure you want to delete this Room Connection?"
            }
        }
    }
    
    var body: some View {
        HStack {
            Button(action: addAction) {
                Image(systemName: "plus").frame(width: 24, height: 24)
            }
            Button(action: showAlert) {
                Image(systemName: "minus").frame(width: 24, height: 24)
            }.alert(
                Text(alertTitle),
                isPresented: $isAlertPresented
            ) {
                Button("Delete") {
                    isAlertPresented = false
                    deleteAction()
                }
                Button("Ignore") {
                    isAlertPresented = false
                }
            } message: {
                Text(alertMessage)
            }
        }.padding().buttonStyle(.borderless)
    }
    
    func showAlert() {
        isAlertPresented = true
    }
}

#Preview {
    ListViewButtons(mode: .Object,  addAction: { () -> Void in return}, deleteAction:{ () -> Void in return} )
}
