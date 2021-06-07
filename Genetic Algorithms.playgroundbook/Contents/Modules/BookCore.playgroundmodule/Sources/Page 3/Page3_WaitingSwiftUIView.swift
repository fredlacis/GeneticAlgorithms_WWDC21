//
//  Page3_WaitingSwiftUIView.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 16/04/21.
//

import SwiftUI

struct Page3_WaitingSwiftUIView: View {
    var body: some View {
        Container {
            VStack {
                Text("Real problems require real solutions! Let's see how it's done.")
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
    }
}

struct Page3_WaitingSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Page3_WaitingSwiftUIView()
    }
}
