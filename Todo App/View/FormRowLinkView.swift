//
//  FormRowLinkView.swift
//  Todo App
//
//  Created by Sergey Hrabrov on 16.07.2023.
//

import SwiftUI

struct FormRowLinkView: View {
    
    // MARK: - Properties
    
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(.white)
            } // ZStack
            .frame(width: 36, height: 36, alignment: .center)
            Text(text)
                .foregroundColor(.gray)
            
            Spacer()
            
            Button {
                //
                guard let url = URL(string: self.link),
                      UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url as URL)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            } // Button
            .tint(Color(.systemGray2))
            
        } // HStack
    }
}

// MARK: - Preview

struct FormRowLinkView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://github.com")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
