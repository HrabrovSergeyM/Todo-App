//
//  EmptyListView.swift
//  Todo App
//
//  Created by Sergey Hrabrov on 16.07.2023.
//

import SwiftUI

struct EmptyListView: View {
    
    // MARK: - Properties
    
    @State private var isAnimated: Bool = false
    @State private var image: String = ""
    @State private var tip: String = ""
    
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData
    
    let images: [String] = [
        "illustration-no1",
        "illustration-no2",
        "illustration-no3"
    ]
    
    let tips: [String] = [
        "Use your time wisely.",
        "Slow and steady wins the race.",
        "Keep it short and sweet.",
        "Put hard tasks first.",
        "Reward yourself after work.",
        "Hard work matters.",
        "Stay consistent in your studying.",
        "Make each day a little better than before."
    ]
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20 ) {
                
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .layoutPriority(1)
                   
                
                Text(tip)
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
            } // VStack
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)
            .offset(y: isAnimated ? 0 : -50)
            .animation(.easeOut(duration: 1.5), value: isAnimated)
            .onAppear {
                image = images.randomElement() ?? ""
                tip = tips.randomElement() ?? ""
                withAnimation {
                    isAnimated.toggle()
                }
            }
        } // ZStack
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("ColorBase"))
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Preview

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
