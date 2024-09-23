//
//  RoomConnectionEditView.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 23/09/2024.
//

import SwiftUI

struct RoomConnectionEditView: View {
    var connection: RoomConnection
    var rooms: [Room]
    @State private var destinyRoom: Room?
    @State private var allowInverseDiraction: Bool
    @State private var direction: Direction?
    
    init(connection: RoomConnection, rooms: [Room]) {
        self.connection = connection
        self.rooms = rooms
        self.destinyRoom = nil
        self.allowInverseDiraction = connection.allowedInverseDirection
        self.direction = nil
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("put the name of the origin room here")
            /*
            Picker("Room to connect", selection: $destinyRoom){
                ForEach(rooms, id: \.self) { room in
                    Text(room.name)
                }
            }
             */
            Picker("Direction", selection: $direction) {
                ForEach(DirectionLabels.sorted{$0.value < $1.value}, id:\.key) {key, value in
                    Text(value).tag(key)
                }
            }
            Picker("Destiny Room", selection: $destinyRoom) {
                ForEach(rooms, id:\.self) { room in
                    Text(room.name).tag(room)
                }
                
            }
            Toggle(isOn: $allowInverseDiraction) {
                Text("Allow inverse direction")
            }
            
            HStack {
                Spacer()
                Button("Cancel", action: cancel)
                Button("Save", action: save)
            }
        }.padding()
    }
    
    func cancel() {
        
    }
    
    func save() {
        
    }
}

#Preview {
    VStack {
        let rooms: [Room] = [
            Room(name: "Kitchen", description: "", project: nil),
            Room(name: "Bathroom", description: "", project: nil),
            Room(name: "Living Room", description: "", project: nil)
        ]
        let connection: RoomConnection = .init(origin: rooms[0], direction: .east, allowedInverseDirection: true)
        RoomConnectionEditView(connection: connection, rooms: rooms)
    }
    
}
