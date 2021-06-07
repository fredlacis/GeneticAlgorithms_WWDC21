//
//  Button.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 13/04/21.
//

import SwiftUI

struct CustomButton: View {
    
    @State var label: String
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action){
            Text(label)
                .font(.custom("Montserrat-Regular", size: 25))
                .padding(.horizontal, 48)
                .padding(.vertical, 8)
                .foregroundColor(.white)
        }
        .background(Color(UIColor(hex: "#59AFAC")!))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 0)
    }
}
