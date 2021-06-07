//
//  Part1.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 13/04/21.
//

import SwiftUI

struct Part1: View {
    
    let columns = [
        GridItem(.fixed(116)),
        GridItem(.fixed(116)),
        GridItem(.fixed(116)),
        GridItem(.fixed(116))
    ]
    
    @Binding var planets: [Planet]
    
    var body: some View {
        VStack {
            Title("1º: Population")
            LazyVGrid(columns: columns, spacing: 8){
                ForEach(self.planets.indices, id: \.self) { i in
                    self.planets[i]
                }
            }
            .onAppear() {
                if self.planets.isEmpty {
                    generateRandomPlanets()
                }
            }
        }
    }
    
    func generateRandomPlanets() {
        self.planets = []
        for _ in 1...16 {
            let newPlanet = Planet()
            self.planets.append(newPlanet)
        }
    }

}
