//
//  RoomsView.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 15/09/2024.
//

import SwiftUI

struct RoomsView: View {
    @Environment(\.modelContext) private var modelContext
    var currentRoom: Room
    
    @State var name: String
    @State var description: String
    
    init(currentRoom: Room) {
        self.currentRoom = currentRoom
        self.name = currentRoom.name
        self.description = currentRoom.desc
    }

    
    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {
            Form {
                TextField("Name", text: $name)
                
                TextEditor(text: $description)
            }
            
            Button(action: saveRoom) {
                Text("Save Room")
            }
        }.padding()
    }
    
    func saveRoom() {
        withAnimation {
            currentRoom.desc = description
            currentRoom.name = name
        }
    }
}


 #Preview {
     VStack {
         let project: Project = Project(name: "My preview Project", firstRoomIndex: 0)
         let room: Room = Room(name: "Preview Room", description: "Description here", project: nil)
         RoomsView(currentRoom: room)
             .modelContainer(for: Project.self, inMemory: true)
     }
 }
 
