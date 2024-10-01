//
//  AdventureStudioApp.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 11/09/2024.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

extension UTType {
    static var adventureStudio = UTType(exportedAs: "com.example.adventureStudio")
}


enum ProjectElement {
    case Rooms
    case Objects
}


/// Gathers all the application run-time variables used to manage the app into one struct
@Observable
class AppState {
    var mode: ProjectElement = .Rooms
}

@main
struct AdventureStudioApp: App {
    @State var appState = AppState()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Obj.self,
            Room.self,
            RoomConnection.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        #if os(iOS) || os(macOS)
        DocumentGroup(editing: [Room.self, RoomConnection.self, Obj.self], contentType: .adventureStudio){
        //DocumentGroup(editing: Room.self, contentType: .adventureStudio){
            ContentView().environment(appState)
        }
        #else
        WindowGroup {
            ContentView().environment(appState)
        }
        .modelContainer(sharedModelContainer)
        #endif
    }
}
