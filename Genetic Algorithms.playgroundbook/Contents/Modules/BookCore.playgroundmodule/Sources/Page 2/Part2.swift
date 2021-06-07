//
//  Part2.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 13/04/21.
//

import SwiftUI

struct Part2: View {
    
    @Binding var planets: [Planet]
    
    let columns = [
        GridItem(.fixed(116)),
        GridItem(.fixed(116)),
        GridItem(.fixed(116)),
        GridItem(.fixed(116))
    ]
    
    var body: some View {
        VStack {
            Title("2º: Selection")
            
            LazyVGrid(columns: columns, spacing: 8){
                ForEach(self.planets.indices, id: \.self) { i in
                    self.planets[i]
                }
            }
        }.onAppear(perform: selection)
    }
    
    func selection() {
        planets.sort(by: { $0.getFitness() > $1.getFitness() })
        planets = Array(planets[0..<4])
    }

}
