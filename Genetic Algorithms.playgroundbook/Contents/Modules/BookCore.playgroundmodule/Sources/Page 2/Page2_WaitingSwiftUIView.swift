//
//  Page2_SwiftUIView.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 13/04/21.
//

import SwiftUI

struct Page2_WaitingSwiftUIView: View {
    var body: some View {
        Container {
            VStack {
                Text("Are you ready to create some planets and make them the better possible?")
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
        .foregroundColor(.white)
    }
}

struct Page2_WaitingSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Page2_SwiftUIView()
    }
}
