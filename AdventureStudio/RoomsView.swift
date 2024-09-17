//
//  RoomsView.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 15/09/2024.
//

import SwiftUI

struct RoomsView: View {
    //@Binding var project: Project
    var currentRoom: Room
    
    @State var name: String
    
    init(currentRoom: Room) {
        self.currentRoom = currentRoom
        self.name = currentRoom.name
    }

    
    var body: some View {
        Form {
            TextField("Name", text: $name)
        }
        /*
        NavigationSplitView {
            List(selection: $currentRoom) {
                ForEach(project.rooms, id: \.self) { room in
                    Text(room.name)
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
            .toolbar {
                ToolbarItem {
                    Button(action: addRoom) {
                        Label("Add Room", systemImage: "plus")
                    }
                }
            }
            //.onDelete(perform: deleteRooms)
        } 
        contente {
        detail: {
            /*
            if let room = currentRoom {
                Text ("Move this into a form")
                /*
                Form {
                    TextField("Name", text: room.name)
                }
                 */
            }
            else {
                Text("Please Select a Room to edit")
            }
             */
        }
        /*
        HStack {
            VStack {
                List(selection: $currentRoom) {
                    ForEach(project.rooms, id: \.self) { room in
                        Text(room.name)
                    }
                }
                
                HStack {
                    Button(action: addRoom) {
                        Label("Add Room", systemImage: "plus")
                    }
                    Button(action: deleteRoom) {
                        Label("Delete Room", systemImage: "minus")
                    }
                }
            }
            /*
            if $currentRoom  {
                Form {
                    TextField("Name", text: $currentRoom.name)
                }
            }
            else {
                Text("Please select a room to edit")
            }
             */
            
        }
         */
         */
    }
    
    func addRoom() {
        
    }
    
    /*
    private func deleteRooms(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(project.rooms[index])
            }
        }
    }
     */
}

/*
 #Preview {
 let fm: FileManager = FileManager.default
 let project: Project = .init(name: "My preview Project", rooms: [], firstRoomIndex: 0)
 
 RoomsView(project: project)
 }
 */
