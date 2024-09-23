//
//  RoomConnectionEditView.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 23/09/2024.
//

import SwiftUI

enum RoomConnectionEditViewMode {
    case Create
    case Edit
}

struct RoomConnectionEditView: View {
    var roomOrigin: Room
    var connection: RoomConnection?
    var rooms: [Room]
    @State private var destinyRoom: Room?
    @State private var allowInverseDirection: Bool
    @State private var direction: Direction?
    @State private var originRoomName: String
    var mode: RoomConnectionEditViewMode
    
    init(roomOrigin: Room, rooms: [Room], connection: RoomConnection? = nil) {
        self.roomOrigin = roomOrigin
        self.originRoomName = self.roomOrigin.name
        self.rooms = rooms
        self.connection = connection
        
        if connection != nil {
            self.connection = connection!
            //self.destinyRoom = rooms.filter({$0.id == connection?.destiny.id})[0]
            let positionOfRoom: Int? = rooms.firstIndex(where: { room in
                room.name == connection?.destiny.name
            })
            
            if positionOfRoom != nil {
                //self.destinyRoom = rooms[positionOfRoom!]
            }
            
            self.allowInverseDirection = connection!.allowedInverseDirection
            self.direction = self.connection!.direction
            self.originRoomName = self.roomOrigin.name
            self.mode = .Edit
        }
        else {
            self.allowInverseDirection = false
            self.mode = .Create
        }
    }
    
    var body: some View {
        Form{
            TextField("Room of Origin", text: $originRoomName).disabled(true)
            Picker("Destiny Room", selection: $destinyRoom) {
                ForEach(rooms, id:\.self) { room in
                    Text(room.name).tag(room)
                }
                
            }
            Picker("Direction", selection: $direction) {
                ForEach(DirectionLabels.sorted{$0.value < $1.value}, id:\.key) {key, value in
                    Text(value).tag(key)
                }
            }
            
            Toggle(isOn: $allowInverseDirection) {
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
        /*
        let connection: RoomConnection = .init(origin: rooms[0], destiny: rooms[1], direction: .east, allowedInverseDirection: true)
        RoomConnectionEditView(roomOrigin: rooms[0], rooms: rooms, connection: connection)
         */
        
        RoomConnectionEditView(roomOrigin: rooms[0], rooms: rooms)
    }
    
}
