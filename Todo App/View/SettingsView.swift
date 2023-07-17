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
    
    @EnvironmentObject var iconSettings: IconNames
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    Section(header: Text("Choose the app icon")) {
                        Picker(selection: $iconSettings.currentIndex, label:
                                HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .strokeBorder(Color.primary, lineWidth: 2)
                                
                                Image(systemName: "paintbrush")
                                    .font(.system(size: 28, weight: .regular, design: .default))
                                    .foregroundColor(Color.primary)
                            }
                            .frame(width: 44, height: 44)
                            
                            Text("App Icons")
                                .fontWeight(.bold)
                                .foregroundColor(Color.primary)
                        } // Label
                        ) {
                            ForEach(0..<iconSettings.iconNames.count) { index in
                                HStack {
                                    Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Blue") ?? UIImage())
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .cornerRadius(8)
                                    
                                    Spacer().frame(width: 8)
                                    
                                    Text(self.iconSettings.iconNames[index] ?? "Blue")
                                        .frame(alignment: .leading)
                                    
                                    
                                } // HStack
                                .padding(3)
                            } // ForEach
                        } // Picker
                        .onReceive([self.iconSettings.currentIndex].publisher.first()) { (value) in
                            let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                            if index != value {
                                UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]) { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                        print("Success! You have changed the app icon.")
                                        
                                    }
                                }
                            }
                        }
                        .pickerStyle(.navigationLink)
                    } // Section Icons
                    .padding(.vertical, 3)
                    
                    Section(header:
                                HStack {
                        Text("Choose the app theme")
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(themes[self.theme.themeSettings].themeColor)
                    } // HStack
                    ) {
                        List {
                            ForEach(themes, id: \.id) { theme in
                                Button {
                                    self.theme.themeSettings = theme.id
                                    UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                } label: {
                                    HStack {
                                        Text(theme.themeName)
                                        Spacer()
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(theme.themeColor)
                                    } // HStack
                                } // Button
                                .accentColor(.primary)
                            } // ForEach
                        } // List
                    } // Section Theme
                    .padding(3)
                    
                    Section {
                        FormRowLinkView(icon: "globe", color: .black, text: "Github", link: "https://github.com/HrabrovSergeyM")
                        FormRowLinkView(icon: "camera", color: .pink, text: "Instagram", link: "https://instagram.com/hrabrov_s")
                    } header: {
                        Text("Follow me on social media")
                    } // Section Links
                    .padding(.vertical, 3)
                    
                    Section {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Sergey Hrabrov")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    } header: {
                        Text("About the application")
                    } // Section About
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
                        .accentColor(themes[self.theme.themeSettings].themeColor)
                } // Button
            } // toolbar
        } // NavigationView
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(IconNames())
    }
}
