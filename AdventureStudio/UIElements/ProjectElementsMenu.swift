//
//  ProjectElementsMenu.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 13/09/2024.
//

import SwiftUI



struct ElementButton: View {
    var title: String
    var image: String
    var action: () -> Void
    var mode: ProjectElement
    @Environment(AppState.self) private var appState
    
    var body: some View {
        let backgroundStyle:  HierarchicalShapeStyle  = appState.mode == mode ? .quinary : .secondary
        
        Button(title, systemImage: image, action: action)
            .background(backgroundStyle)
    }
}

struct ProjectElementsMenu: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        HStack {
            ElementButton(title: "Rooms", image: "house.fill", action: setRooms, mode: .Rooms)
                .scaledToFill()
            ElementButton(title: "Objects", image: "cube.fill", action: setObjects, mode: .Objects)
                .scaledToFill()

        }.padding(4)
    }
    
    func setRooms() {
        appState.mode = .Rooms
    }
    
    func setObjects() {
        appState.mode = .Objects
    }
}

#Preview {
    VStack {
        ProjectElementsMenu()
            .modelContainer(for: Project.self, inMemory: true)
    }
}
