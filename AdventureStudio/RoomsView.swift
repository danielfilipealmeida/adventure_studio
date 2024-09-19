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
        VStack(alignment: .trailing) {
            Form {
                TextField("Name", text: $name)
                TextEditor(text: $description)
            }
            Button(action: saveRoom) {
                Text("Save Room")
            }
        }
       
        
    }
    
    func addRoom() {
        
    }
    
    func saveRoom() {
        withAnimation {
            currentRoom.desc = description
            currentRoom.name = name
        }
       
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
