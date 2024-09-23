//
//  RoomConnectionListView.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 21/09/2024.
//

import SwiftUI
import SwiftData

struct RoomConnectionListView: View {
    var currentRoom: Room
    @State var currentRoomConnection: RoomConnection?
    
    var body: some View {
        VStack(alignment: .trailing) {
            /*
            List(selection: $currentRoomConnection) {
                ForEach(currentRoom.connections, id:\.self) { connection in
                    Text(connection.destiny.name)
                }
            }
             */
            HStack {
                Button(action: editRoomConnection) {
                    Image(systemName: "pencil").frame(width: 24, height: 24)
                }.padding().buttonStyle(.borderless)
                Spacer()
                ListViewButtons(addAction: addRoomConnection, deleteAction: deleteRoomConnection)
            }
            
            
        }
    }
    
    private func addRoomConnection(){
    }
    
    private func deleteRoomConnection(){
    }
    
    private func editRoomConnection() {
        
    }
}

#Preview {
    VStack {
        
        let currentRoom = {
            let schema = Schema([
                Project.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            
            do {
                let modelContainer =  try ModelContainer(for: schema, configurations: [modelConfiguration])
                
                
                let currentRoom: Room = .init(name: "Living Room", description: "", project: nil)
                let room1: Room = .init(name: "Kitchen", description: "", project: nil)
                let room2: Room = .init(name: "Bathroom", description: "", project: nil)
                modelContainer.mainContext.insert(currentRoom)
                modelContainer.mainContext.insert(room1)
                modelContainer.mainContext.insert(room2)
                
                /*
                let roomConnection1: RoomConnection = .init(origin: currentRoom, destiny: room1, direction: .east, allowedInverseDirection: true)
                let roomConnection2: RoomConnection = .init(origin: currentRoom, destiny: room2, direction: .west, allowedInverseDirection: true)
                modelContainer.mainContext.insert(roomConnection1)
                modelContainer.mainContext.insert(roomConnection2)
                
                currentRoom.connections.append(roomConnection1)
                currentRoom.connections.append(roomConnection2)
                */
                return currentRoom
            }
            
            catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
            
            
        }()
         /*
        let projectsData: [Dictionary] = [
            [
                "name": "test project",
                "rooms": [
                    [
                        "name": "Living room",
                        "description": "",
                        "connections": [
                            [
                                "index": 1,
                                "direction": Direction.east
                            ],
                            [
                                "index": 2,
                                "direction": Direction.west
                            ]
                        ]
                    ],
                    [
                        "name": "Living room",
                        "description": "Kitchen",
                        "connections": []
                    ],
                    [
                        "name": "Living room",
                        "description": "Kitchen",
                        "connections": []
                    ]
                    
                ]
            ]
        ]
        
        let previewContainer = getPreviewModelContainer(projectsData: projectsData)
        @Query var projects: [Project]
        let currentRoom: Room = projects[0].rooms[0]
        */
        RoomConnectionListView(currentRoom: currentRoom)
            
            //.modelContainer(previewContainer)
    }
    
}
