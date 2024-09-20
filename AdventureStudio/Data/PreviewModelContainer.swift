//
//  PreviewModelContainer.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 19/09/2024.
//

import Foundation
import SwiftData

/// Helper function that receives an array of dictionaries defining the data of the in-memory database and returns
/// a ModelContainer with data
/// - Parameter projectsData: an array of dictionaries with all projects data
/// - Returns: <#description#>
@MainActor func getPreviewModelContainer(projectsData: [Dictionary<String, Any>]) -> ModelContainer {
    do {
        let schema = Schema([
            Project.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            let modelContainer =  try ModelContainer(for: schema, configurations: [modelConfiguration])
                    
            // todo, extract this into a new function. more functions will be needed for setting other database tables
            for project in projectsData {
                
               let rooms:[Room] = {
                   var rooms: [Room] = []
                   for room in project["rooms"] as! [Dictionary<String, String>] {
                       let newRoom = Room(name: room["name"] ?? "", description: room["desc"] ?? "", project: nil)
                       rooms.append(newRoom)
                   }
                   
                   return rooms
               }()
                 
                
                // todo: add objects
               let newProject = Project(name: project["name"] as! String, firstRoomIndex: project["firstRoomIndex"] as? Int ?? 0)
                
               
                modelContainer.mainContext.insert(newProject)
            }
             
            
            return modelContainer
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
