//
//  ContentView.swift
//  Todo App
//
//  Created by Sergey Hrabrov on 16.07.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoEntity.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<TodoEntity>
    
    @State private var showingAddTodoView: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                Text("Hello")
            } // List
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: {
                    self.showingAddTodoView.toggle()
                    print(showingAddTodoView)
                }) {
                    Image(systemName: "plus")
                } // Add Button
                .sheet(isPresented: $showingAddTodoView) {
                    AddTodoView().environment(\.managedObjectContext, self.viewContext)
                }
            }
        } // NavigationView
    }
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
