//
//  ProjectDetails.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 13/09/2024.
//

import SwiftUI

struct ProjectDetails: View {
    var project: Project
    @Environment(AppState.self) var appState
    
    var body: some View {
        VStack {
            ProjectElementsMenu()
            /*
            switch appState.mode {
            case .Rooms:
                RoomsView(project: project).scaledToFill().border(.blue, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            case .Objects:
                ObjectsView(project: project).scaledToFill()
            }
             */
        }
    }
}

/*
#Preview {
    VStack {
        @State var appState = AppState()
        ProjectDetails(appState: $appState)
    }
   
}
*/
