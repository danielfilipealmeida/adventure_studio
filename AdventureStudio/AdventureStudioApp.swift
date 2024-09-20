//
//  AdventureStudioApp.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 11/09/2024.
//

import SwiftUI
import SwiftData

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
            Object.self,
            Room.self,
            Project.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView().environment(appState)
        }
        .modelContainer(sharedModelContainer)
    }
}
