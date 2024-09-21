//
//  ListViewButtons.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 20/09/2024.
//

import SwiftUI

struct ListViewButtons: View {
    var addAction : () -> Void
    var deleteAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: addAction) {
                Image(systemName: "plus").frame(width: 24, height: 24)
            }
            Button(action: deleteAction) {
                Image(systemName: "minus").frame(width: 24, height: 24)
            }
        }.padding().buttonStyle(.borderless)
    }
}

#Preview {
    ListViewButtons(addAction: { () -> Void in return}, deleteAction:{ () -> Void in return} )
}
