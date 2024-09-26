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
    @State private var currentObject: Obj?

    var body: some View {
        NavigationSplitView {
            List(selection: $currentProject) {
                ForEach(projects, id: \.self) { project in
                    NavigationLink(project.name, value: project)
                }
                .onDelete(perform: deleteProjects)
            }.onChange(of: currentProject) {
                appState.currentProject = currentProject
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
                    RoomsListView(
                        currentRoom: $currentRoom,
                        currentProject: $currentProject,
                        rooms: project.rooms
                    )
                }
                else {
                    Text ("Please select a Project")
                }
            }
            else if appState.mode == .Objects {
               
                if let project = currentProject {
                    ObjectsListView(
                        currentObject: $currentObject,
                        currentProject: $currentProject,
                        objects: project.objects
                    )
                }
                
            }
            else {
                Text("Invalid mode")
            }
            
        } detail: {
            if let project = currentProject {
                if appState.mode == .Rooms {
                    if let room = currentRoom {
                        RoomsView(currentRoom: room, rooms: project.rooms)
                            .id(room.id)
                    } else {
                        Text("Select a Room")
                    }
                }
                if appState.mode == .Objects {
                    if let object = currentObject {
                        ObjectsView(currentObject: object)
                            .id(object.id)
                    } else {
                        Text("Select an Object")
                    }
                }
            } else {
                Text("No project selected")
            }
            
        }
        
    }

    private func addProject() {
        withAnimation {
            let newProject = Project(name: "New Project", firstRoomIndex: 0)
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
    
    
    
    private func setRoomMode() {
        appState.mode = .Rooms
    }
    
    private func setObjectMode() {
        appState.mode = .Objects
    }
}



#Preview {
    VStack {
        @State var appState = AppState()
        let projectsData:[Dictionary] = [
            [
                "name": "Project one",
                "rooms": [
                    [
                        "name": "Garden",
                        "desc": "Lorem Ipsum"
                    ],
                    [
                        "name": "Porch",
                        "desc": "blah blah"
                    ]
                ]
            ],
            [
                "name": "Project two",
                "rooms": [
                    [
                        "name": "Green path",
                        "desc": "Lorem Ipsum"
                    ],
                    [
                        "name": "Mountain top",
                        "desc": "blah blah"
                    ]
                ]
            ]
        ]
        let previewContainer = getPreviewModelContainer(projectsData: projectsData)
        ContentView()
            .modelContainer(previewContainer)
            .environment(appState)
    }
    
    
}

