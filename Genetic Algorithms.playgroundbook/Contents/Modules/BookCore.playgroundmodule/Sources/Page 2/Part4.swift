//
//  Part4.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 13/04/21.
//

import SwiftUI

struct Part4: View {
    @Binding var planets: [Planet]

    var body: some View {
        VStack {
            Title("4º: Repeat")
            Text("Top 2 individuals of the population:")
                .font(.custom("Montserrat-Regular", size: 20))
            HStack {
                planets[0]
                planets[1]
            }
        }
    }
}
