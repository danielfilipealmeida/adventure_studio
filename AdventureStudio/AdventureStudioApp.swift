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
            ContentView()
                .environment(appState)
        }
        .commands {
            CommandGroup(before: .saveItem) {
                Button("Export") {
                    self.export()
                }
            }
        }
        #else
        WindowGroup {
            ContentView().environment(appState)
        }
        /*
        .commands {
            ExportMenuCommand()
        }
         */
        .modelContainer(sharedModelContainer)
        #endif
    }
    
    func export() {
        let panel = NSSavePanel()
        panel.canCreateDirectories = true
        panel.title = "Export to..."
        panel.message = "Please select the destination of the export"
        if panel.runModal() == .OK {
            do {
                let rooms: [Room] = try sharedModelContainer.mainContext.fetch(FetchDescriptor<Room>())
                let connections: [RoomConnection] = try sharedModelContainer.mainContext.fetch(FetchDescriptor<RoomConnection>())
                let objects: [Obj] = try sharedModelContainer.mainContext.fetch(FetchDescriptor<Obj>())
                let exporter: Exporter = Exporter(url: panel.url!, rooms: rooms, roomConnections: connections, objects: objects)
                try exporter.run()
            }
            catch {
                let alert: NSAlert = NSAlert()
                alert.messageText = "Error Exporting Project"
                alert.runModal()
            }
            
        }
    }
    
    /*
    struct ExportMenuCommand: Commands {
        var body: some Commands {
            CommandGroup(before: .saveItem) {
                Button("Export") {
                    self.export()
                }
            }
        }
    }
    */
    
}


