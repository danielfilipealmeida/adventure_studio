//
//  RoomsView.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 15/09/2024.
//

import SwiftUI

struct RoomsView: View {
    @Environment(\.modelContext) private var modelContext
    @State var currentRoom: Room
    var rooms: [Room]
    
    @State var name: String
    @State var description: String
    
    init(currentRoom: Room, rooms: [Room]) {
        self.currentRoom = currentRoom
        self.name = currentRoom.name
        self.description = currentRoom.desc
        self.rooms = rooms
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {
            Spacer()
            Form {
                TextField("Name", text: $name)
                
                LabeledContent("Descriptions") {
                    TextEditor(text: $description)
                }
                
                
                LabeledContent("Connections") {
                    RoomConnectionListView(currentRoom: currentRoom, rooms: rooms)
                }
            
            }
            Spacer()
            Button(action: saveRoom) {
                Text("Save Room")
            }
            Spacer()
        }.padding()
    }
    
    func saveRoom() {
        withAnimation {
            currentRoom.desc = description
            currentRoom.name = name
        }
    }
}

/*
 #Preview {
     VStack {
         let project: Project = Project(name: "My preview Project", firstRoomIndex: 0)
         let room: Room = Room(name: "Preview Room", description: "Description here", project: nil)
         RoomsView(currentRoom: room, rooms: [room])
             .modelContainer(for: Project.self, inMemory: true)
     }
 }
 
*/
