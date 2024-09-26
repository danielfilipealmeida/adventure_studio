//
//  RoomConnectionListView.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 21/09/2024.
//

import SwiftUI
import SwiftData

struct RoomConnectionListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppState.self) private var appState
    
    @State var currentRoom: Room
    var rooms: [Room]
    @State var currentRoomConnection: RoomConnection?
    @State var showRoomConnectionEditView: Bool = false
    @Query private var connections: [RoomConnection]
    
    var body: some View {
        VStack(alignment: .trailing) {
            List(selection: $currentRoomConnection) {
                ForEach(connections, id:\.self) { connection in
                    Text(connection.destiny!.name)
                }
            }
            HStack {
                Button(action: editRoomConnection) {
                    Image(systemName: "pencil").frame(width: 24, height: 24)
                }.padding().buttonStyle(.borderless)
                    
                Spacer()
                ListViewButtons(mode: .RoomConnection, addAction: addRoomConnection, deleteAction: deleteRoomConnection)
            }
        }
        .popover(isPresented: $showRoomConnectionEditView) {
            RoomConnectionEditView(showView: $showRoomConnectionEditView, roomOrigin: currentRoom, rooms: rooms)
        }
    }
    
    private func addRoomConnection(){
        showRoomConnectionEditView = true
        /*
        withAnimation {
            if let currentProject: Project = appState.currentProject {
                var newRoomConnection: RoomConnection = .init(project: currentProject, origin: currentRoom, destiny: rooms[0], direction: .east, allowedInverseDirection: true)
                modelContext.insert(newRoomConnection)
            }
            
        }
        */
    }
    
    private func deleteRoomConnection(){
        withAnimation {
            guard let _ = currentRoomConnection else { return }
            modelContext.delete(currentRoomConnection!)
        }
    }
    
    private func editRoomConnection() {
        if currentRoomConnection == nil {
            return
        }
        showRoomConnectionEditView = true
    }
}


#Preview {
    VStack {
        var currentRoom: Room = Room(name: "Living Room", description: "", project: nil)
        let room1: Room = .init(name: "Kitchen", description: "", project: nil)
        let room2: Room = .init(name: "Bathroom", description: "", project: nil)
        var connections: [RoomConnection] = []
        
        RoomConnectionListView(currentRoom: currentRoom, rooms: [currentRoom, room1, room2])
    }
}
