//
//  RoomsListView.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 19/09/2024.
//

import SwiftUI


struct RoomsListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var currentRoom: Room?
    @Binding var currentProject: Project?
    let rooms: [Room]
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            List(selection: $currentRoom) {
                ForEach(rooms, id:\.self) { room in
                    Text(room.name)
                }
            }
            ListViewButtons(addAction: addRoom, deleteAction: deleteRoom)
        }
    }
    
    private func addRoom(){
        withAnimation {
            guard let _ = currentProject else { return }
            let newRoom = Room(name: "New Room", description: "Add the room description", project: currentProject!)
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
}



 #Preview {
     
     VStack {
         @State var currentProject: Project? = Project(name: "Test Project", firstRoomIndex: 0)
         var rooms: [Room] = {
             // adding another room to the array breaks the preview
             var rooms: [Room] = [
                Room(name: "Preview room", description: "The description", project: currentProject)
             ]
             return rooms
         }()
         @State var currentRoom: Room? = rooms[0]
         RoomsListView(currentRoom: $currentRoom, currentProject: $currentProject, rooms: rooms)
     }
 }

 
