//
//  ExporterTests.swift
//  AdventureStudioTests
//
//  Created by Daniel Almeida on 10/10/2024.
//

import XCTest
import SwiftData


final class ExporterTests: XCTestCase {

    @MainActor func testExporter() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Room.self, configurations: config)
        let context = container.mainContext
        
        let room1: Room = Room(name: "Room 1", description: "Some description for room 1")
        let room2: Room = Room(name: "Room 2", description: "Some description for room 2")
        context.insert(room1)
        context.insert(room2)
        let connection1 = RoomConnection(origin: room1, destiny: room2, direction: .east, allowedInverseDirection: true)
        context.insert(connection1)
        room1.connections = [connection1]
        
        let obj1 = Obj(name: "knife", description: "A description", pickable: true)
        let obj2 = Obj(name: "mirror", description: "A description", pickable: true)
        
        let exporter: Exporter = Exporter(
            url: Bundle.main.executableURL!,
            rooms: [room1, room2],
            roomConnections: [connection1],
            objects: [obj1, obj2]
        
        )
        let jsonEncoder: JSONEncoder = JSONEncoder()
        let jsonData: Data = try jsonEncoder.encode(exporter)
        
        let resultDict = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
       
        // update when adding more data to the export
        XCTAssert(resultDict!.keys.count == 3)
        XCTAssertTrue(Array(resultDict!.keys).contains(["rooms"]))
        XCTAssertTrue(Array(resultDict!.keys).contains(["roomConnections"]))
        XCTAssertTrue(Array(resultDict!.keys).contains(["objects"]))        
    }

}
