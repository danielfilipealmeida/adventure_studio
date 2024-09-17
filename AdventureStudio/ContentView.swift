//
//  ContentView.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 11/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppState.self) private var appState
    @Query private var projects: [Project]
    @State private var currentProject: Project?
    @State private var currentRoom: Room?

    var body: some View {
        NavigationSplitView {
            List(selection: $currentProject) {
                ForEach(projects, id: \.self) { project in
                    NavigationLink(project.name, value: project)
                }
                .onDelete(perform: deleteProjects)
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button(action: addProject) {
                        Label("Add Project", systemImage: "plus")
                    }
                }
            }
        } content: {
            if let project = currentProject {
                VStack {
                    Button(action: addRoom) {
                        Label("Add Room", systemImage: "plus")
                    }
                    List(selection: $currentRoom) {
                        ForEach(project.rooms, id:\.self) { room in
                            Text(room.name)
                        }
                    }
                }
                
                
            }
            else {
                Text ("Please select a Project")
            }
        } detail: {
            if let room = currentRoom {
                RoomsView(currentRoom: room)
            } else {
                Text("Select a Room")
            }
        }
    }

    private func addProject() {
        withAnimation {
            let newProject = Project(name: "New Project", rooms: [], firstRoomIndex: 0)
            modelContext.insert(newProject)
        }
    }

    private func deleteProjects(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(projects[index])
            }
        }
    }
    
    private func addRoom(){
        withAnimation {
            let newRoom = Room(name: "New Room", description: "Add the room description", project: currentProject!)
            modelContext.insert(newRoom)
            
        }
    }
}

/*
 #Preview {
 VStack {
 @State var appState = AppState()
 ContentView(appState: $appState)
 .modelContainer(for: Project.self, inMemory: true)
 }
 }
 */
