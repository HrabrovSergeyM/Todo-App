//
//  SettingsView.swift
//  Todo App
//
//  Created by Sergey Hrabrov on 16.07.2023.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Properties
    
    @Environment(\.isPresented) var isPresented
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    Section {
                        FormRowLinkView(icon: "globe", color: .black, text: "Github", link: "https://github.com/HrabrovSergeyM")
                        FormRowLinkView(icon: "camera", color: .pink, text: "Instagram", link: "https://instagram.com/hrabrov_s")
                    } header: {
                        Text("Follow me on social media")
                    } // Section 1
                    .padding(.vertical, 3)
                    
                    Section {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Sergey Hrabrov")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    } header: {
                        Text("About the application")
                    } // Section 2
                    .padding(.vertical, 3)
                    
                } // Form
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
            } // VStack
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
            .toolbar {
                Button {
                    self.dismiss()
                } label: {
                    Image(systemName: "xmark")
                } // Button
            } // toolbar
        } // NavigationView
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
