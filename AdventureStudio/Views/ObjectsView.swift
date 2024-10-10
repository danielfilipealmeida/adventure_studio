//
//  ObjectsView.swift
//  AdventureStudio
//
//  Created by Daniel Almeida on 15/09/2024.
//

import SwiftUI

struct ObjectsView: View {
    @Environment(\.modelContext) private var modelContext
    var currentObject: Obj
    
    @State var name: String
    @State var description: String
    @State var pickable: Bool
    
    init(currentObject: Obj) {
        self.currentObject = currentObject
        self.name = currentObject.name
        self.description = currentObject.desc
        self.pickable = currentObject.pickable
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {
            Spacer()
            Form {
                TextField("Name", text: $name)
                LabeledContent("Description") {
                    TextEditor(text: $description)
                }
                Toggle(isOn: $pickable) {
                    Text("Pickable")
                }
            }
            Spacer()
            Button(action: saveObject) {
                Text("Save Object")
            }
            Spacer()
        }.padding()
    }
    
    func saveObject() {
        withAnimation {
            currentObject.desc = description
            currentObject.name = name
            currentObject.pickable = pickable
        }
       
    }
}


#Preview {
    VStack {
        var object: Obj = Obj(name: "Knife", description: "A sharp steel knife", pickable: true)
        ObjectsView(currentObject: object)
    }
    
}

