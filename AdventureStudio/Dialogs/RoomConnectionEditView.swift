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
    @Environment(\.modelContext) private var modelContext
    @Environment(AppState.self) private var appState
    
    
    var roomOrigin: Room
    var connection: RoomConnection?
    var rooms: [Room]
    
    @State private var destinyRoom: Room?
    @State private var allowInverseDirection: Bool
    @State private var direction: Direction
    @State private var originRoomName: String
    @Binding var mode: RoomConnectionEditViewMode
    @Binding var showView: Bool
    
    init(showView: Binding<Bool>, mode: Binding<RoomConnectionEditViewMode>, roomOrigin: Room, rooms: [Room], connection: RoomConnection? = nil) {
        self._showView = showView
        self._mode = mode
        self.roomOrigin = roomOrigin
        self.originRoomName = self.roomOrigin.name
        self.rooms = rooms
        self.connection = connection
        
        if self._mode.wrappedValue == .Edit {
            self.connection = connection!
            
            self.destinyRoom = connection!.destiny
            self.allowInverseDirection = connection!.allowedInverseDirection
            self.direction = connection!.direction
            self.originRoomName = self.roomOrigin.name
        }
        else {
            self.allowInverseDirection = false
            self.direction = .north
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
        self.showView = false
        
    }
    
    func save() {
        withAnimation {
            if let newDestinyRoom = destinyRoom{
                if _mode.wrappedValue == .Create {
                    var newRoomConnection: RoomConnection = .init(
                        origin: roomOrigin,
                        destiny: newDestinyRoom,
                        direction: direction,
                        allowedInverseDirection: allowInverseDirection
                    )
                    modelContext.insert(newRoomConnection)
                }
                else {
                    connection?.destiny = newDestinyRoom
                    connection?.direction = direction
                    connection?.allowedInverseDirection = allowInverseDirection
                }
                
            }
            
        }
        self.showView = false
        
    }
}

#Preview {
    VStack {
        let rooms: [Room] = [
            Room(name: "Kitchen", description: ""),
            Room(name: "Bathroom", description: ""),
            Room(name: "Living Room", description: "")
        ]
        @State var show: Bool = true
        /*
        let connection: RoomConnection = .init(origin: rooms[0], destiny: rooms[1], direction: .east, allowedInverseDirection: true)
        RoomConnectionEditView(roomOrigin: rooms[0], rooms: rooms, connection: connection)
         */
        @State var mode: RoomConnectionEditViewMode = .Edit
        RoomConnectionEditView(showView: $show, mode: $mode, roomOrigin: rooms[0], rooms: rooms)
    }
    
}
