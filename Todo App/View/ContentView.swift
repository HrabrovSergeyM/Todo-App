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
    @State private var animatingButton: Bool = false
    
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
                        } label: {
                            Image(systemName: "plus")
                        } // Add Button
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
            .sheet(isPresented: $showingAddTodoView) {
                AddTodoView().environment(\.managedObjectContext, self.viewContext)
            }
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(.blue)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(.blue)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    } // Group
                    .animation(.easeOut(duration: 2).repeatForever(autoreverses: true), value: animatingButton)
                    
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    } // Button
                    )
                    .onAppear {
                        withAnimation {
                            self.animatingButton.toggle()
                        }
                    }
                } // ZStack
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                , alignment: .bottomTrailing
            )
            
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
