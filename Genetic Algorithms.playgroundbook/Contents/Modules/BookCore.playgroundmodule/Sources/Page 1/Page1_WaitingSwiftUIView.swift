//
//  Page1_SwiftUIView.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 09/04/21.
//

import SwiftUI
import PlaygroundSupport

public struct Page1_WaitingSwiftUIView: View{
    
    @State private var viewGeometry: CGRect = CGRect()
    
    @State private var spin: Bool = false
    
    var foreverAnimation: Animation {
            Animation.easeInOut(duration: 20.0)
                .repeatForever(autoreverses: true)
        }

    
    public var body: some View {
        Container {
            VStack {
                Text("Let's learn about Natural Selection")
                    .font(.custom("Montserrat-Bold", size: 30))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text("Click on Run My Code whenever you're ready!")
                    .font(.custom("Montserrat-Regular", size: 20))
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .foregroundColor(.white)
        }
        .overlay(Color.clear.modifier(GeometryGetterMod(rect: $viewGeometry)))
    }

}

struct Page1_WaitingSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Page1_SwiftUIView()
    }
}
