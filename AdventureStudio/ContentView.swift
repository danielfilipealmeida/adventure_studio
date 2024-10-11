//
//  ContentView.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 11/09/2024.
//

import SwiftUI
import SwiftData

let titles: [ProjectElement: String] = [
    .Objects: "Adventure Studio > Objects",
    .Rooms: "Adventure Studio > Rooms"
]

let backgroundColors:[ProjectElement: Color] = [
    .Objects: Color.orange.opacity(0.05),
    .Rooms: Color.blue.opacity(0.05)
]

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppState.self) private var appState
    @Query private var rooms: [Room]
    @Query private var objects: [Obj]
    @State private var currentRoom: Room?
    @State private var currentObject: Obj?

    var body: some View {
        NavigationSplitView {
            if appState.mode == .Rooms {
                List(selection: $currentRoom) {
                    ForEach(rooms, id: \.self) { room in
                        NavigationLink(room.name, value: room)
                    }
                }
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
                .toolbar {
                    ToolbarItem {
                        Button(action: addRoom) {
                            Label("Add Room", systemImage: "plus")
                        }
                        
                    }
                    ToolbarItem {
                        Button(action: deleteRoom) {
                            Label("Delete Room", systemImage: "minus")
                        }
                    }
                    
                    ToolbarItem {
                        Button(action: setObjectMode) {
                            Label("Objects Mode", systemImage: "shippingbox.fill")
                        }
                    }
                }
            }
            else if appState.mode == .Objects {
                List(selection: $currentObject) {
                    ForEach(objects, id: \.self) { object in
                        NavigationLink(object.name, value: object)
                    }
                }
                .navigationSplitViewColumnWidth(min: 180, ideal: 200)
                .toolbar {
                    ToolbarItem {
                        Button(action: addObject) {
                            Label("Add Object", systemImage: "plus")
                        }
                        
                    }
                    ToolbarItem {
                        Button(action: deleteObject) {
                            Label("Delete Object", systemImage: "minus")
                        }
                    }
                    
                    
                    ToolbarItem {
                        Button(action: setRoomMode) {
                            Label("Rooms Mode", systemImage: "house.fill")
                        }
                    }
                }
            }
        }
        detail: {
            if appState.mode == .Rooms {
                if let room = currentRoom {
                    RoomsView(currentRoom: room, rooms: rooms)
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
        }.navigationTitle(titles[appState.mode] ?? "no title")
            .background(backgroundColors[appState.mode])
        
    }
    
    private func addObject() {
        withAnimation {
            let newObject = Obj(name: "New Object",
                                description: "Add the object description",
                                pickable: true)
            modelContext.insert(newObject)
        }
    }
    
    private func deleteObject() {
        withAnimation {
            guard let object = currentObject else { return }
            modelContext.delete(object)
            currentObject = nil
        }
    }
    
    private func addRoom() {
        withAnimation {
            let newRoom = Room(name: "New Room", description: "Add the room description")
            modelContext.insert(newRoom)
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



#Preview {
    VStack {
        @State var appState = AppState()
        
        let previewContainer = getPreviewModelContainer(
            rooms: [
                [
                    "name": "Garden",
                    "desc": "Lorem Ipsum"
                ],
                [
                    "name": "Porch",
                    "desc": "blah blah"
                ]
            ],
            objects: [
                [
                    "name": "Knife",
                    "desc": "blah"
                ]
                
            ]
        )
        ContentView()
            .modelContainer(previewContainer)
            .environment(appState)
    }
    
    
}

