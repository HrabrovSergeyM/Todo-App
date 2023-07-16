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
    private var todos: FetchedResults<TodoEntity>
    
    @State private var showingAddTodoView: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(self.todos, id: \.self) { todo in
                        HStack {
                            Text(todo.name ?? "Unknown")
                            
                            Spacer()
                            
                            Text(todo.priority ?? "Unknown")
                        } // HStack
                    }
                    .onDelete(perform: deleteTodo)
                } // List
                .navigationTitle("Todo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            self.showingAddTodoView.toggle()
                            //                        addItem()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $showingAddTodoView) {
                            AddTodoView().environment(\.managedObjectContext, self.viewContext)
                        }
                        
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
            }
                
                // MARK: - No todos
                if todos.isEmpty {
                    EmptyListView()
                }
                
            } // ZStack
        } // NavigationView
    }
    
    // MARK: - Function
    
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            viewContext.delete(todo)
            
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
