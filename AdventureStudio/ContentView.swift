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
                ToolbarItem {
                    Button(action: setRoomMode) {
                        Label("Rooms Mode", systemImage: "house.fill")
                    }
                }
                ToolbarItem {
                    Button(action: setObjectMode) {
                        Label("Objects Mode", systemImage: "shippingbox.fill")
                    }
                }
             
            }
        } content: {
            if appState.mode == .Rooms {
                if let project = currentProject {
                    VStack(alignment: .trailing, spacing: 0) {
                        
                        
                        
                        List(selection: $currentRoom) {
                            ForEach(project.rooms, id:\.self) { room in
                                Text(room.name)
                            }
                        }
                        
                        HStack {
                            Button(action: addRoom) {
                                //Label("Add Room", systemImage: "plus")
                                Image(systemName: "plus").frame(width: 24, height: 24)
                            }
                            Button(action: deleteRoom) {
                                Image(systemName: "minus").frame(width: 24, height: 24)
                            }
                        }.padding().buttonStyle(.borderless)
                    }
                    
                    
                }
                else {
                    Text ("Please select a Project")
                }
            }
            else if appState.mode == .Objects {
                Text("Objects form. implement")
            }
            else {
                Text("Invalid mode")
            }
            
        } detail: {
            if let room = currentRoom, let project = currentProject {
                RoomsView(currentRoom: room)
                    .id(room.id)
                    .padding()
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
            guard let project = currentProject else { return }
            
            let newRoom = Room(name: "New Room", description: "Add the room description", project: currentProject!)
            modelContext.insert(newRoom)
            
            //try? modelContext.save()
            
        }
    }
    
    private func deleteRoom() {
        withAnimation {
            guard let project = currentRoom else { return }
            
            modelContext.delete(project)
            currentRoom = nil
        }
    }
    
    private func setRoomMode() {
        appState.mode = .Rooms
    }
    
    private func setObjectMode() {
        appState.mode = .Objects
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
