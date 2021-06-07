//
//  Planet.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 13/04/21.
//

import SwiftUI

struct Planet: View {
    
    public let frame = CGSize(width: 116, height: 24+100+44)
    
    var water: CGFloat = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) // Percentage of surface water
    
    var atmosphere: CGFloat = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) // Earth 100 miles
    
    var energy: CGFloat = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) //
    
    var nutrientCirculation: CGFloat = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) // Ideal 0.8
    
    var color: Color = Color.clear
    
    var overlays: [String] = []
    
    init() {
        generateStyle()
    }
    
    var body: some View {
        ZStack {
            BlurView(style: .light)
            VStack(spacing: 8) {
                planet
//                debug
                statusBar
                    .padding(.top, 8)
            }
            .padding(8)
        }
        .frame(width: frame.width, height: frame.height)
        .cornerRadius(15)
    }
    
    var planet: some View {
        ZStack{
            Image("Atmosphere")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .scaleEffect(atmosphere.map(from: 0...1, to: 0.8...1))
            ZStack {
                    Circle()
                        .foregroundColor(.gray)
                    Circle()
                        .foregroundColor(color)
                    ForEach(overlays, id: \.self) { overlay in
                        Image(overlay)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                    }
            }
            .frame(width: 75, height: 75)
        }
        .frame(width: 100, height: 100)
    }
    
    var debug: some View {
        VStack(spacing: 0){
            Text("\(self.getFitness())").bold().font(.footnote)
            Text("\(water)").font(.footnote)
        }
    }
    
    var statusBar: some View {
        HStack(alignment: .bottom){
            VStack(spacing: 4) {
                Rectangle()
                    .frame(width: 10, height: 30*water)
                    .foregroundColor(getBarColor(value: water, ideal: 0.7, tolerance: 0.1))
                Image(systemName: "drop.fill")
                    .frame(width: 10, height: 10)
            }
            VStack(spacing: 4) {
                Rectangle()
                    .frame(width: 10, height: 30*atmosphere)
                    .foregroundColor(getBarColor(value: atmosphere, ideal: 0.5, tolerance: 0.1))
                Image(systemName: "circle")
                    .frame(width: 10, height: 10)
            }
            VStack(spacing: 4) {
                Rectangle()
                    .frame(width: 10, height: 30*energy)
                    .foregroundColor(getBarColor(value: energy, ideal: 0.5, tolerance: 0.1))
                Image(systemName: "sun.max.fill")
                    .frame(width: 10, height: 10)
            }
            VStack(spacing: 4) {
                Rectangle()
                    .frame(width: 10, height: 30*nutrientCirculation)
                    .foregroundColor(getBarColor(value: nutrientCirculation, ideal: 0.8, tolerance: 0.1))
                Image(systemName: "aqi.high")
                    .frame(width: 10, height: 10)
            }
        }
        .frame(height: 44)
    }
    
    private mutating func generateStyle() {
        self.overlays = []
        if self.water > 0.5 {
            self.color = Color.blue.opacity(Double(water.map(from: 0.5...1, to: 0.2...1)))
            self.overlays.append("Blueish_Overlay_\(Int.random(in: 1...2))")
            if Int.random(in: 0...100) > 50 {
                self.overlays.append("Blueish_Overlay_\(Int.random(in: 3...4))")
            }
        } else {
            self.color = Color.red.opacity(Double(water.map(from: 0...0.5, to: 0.4...1)))
            if Int.random(in: 0...100) > 20 {
                self.overlays.append("Redish_Overlay_\(Int.random(in: 1...2))")
            } else {
                self.overlays.append("Redish_Overlay_1")
                self.overlays.append("Redish_Overlay_2")
            }
        }
    }
    
    func getBarColor(value: CGFloat, ideal: CGFloat, tolerance: CGFloat) -> Color {
        if abs(value.distance(to: ideal)) > tolerance {
            return Color.white
        } else {
            return Color.green
        }
    }
    
    public func getFitness() -> CGFloat {
        let waterFitness = getAttFitness(value: water, ideal: 0.7)
        let atmosphereFitness = getAttFitness(value: atmosphere, ideal: 0.5)
        let energyFitness = getAttFitness(value: energy, ideal: 0.5)
        let nutrientCirculationFitness = getAttFitness(value: nutrientCirculation, ideal: 0.8)
        
        return waterFitness + atmosphereFitness + energyFitness + nutrientCirculationFitness
    }
    
    private func getAttFitness(value: CGFloat, ideal: CGFloat) -> CGFloat {
        let distance = abs(value.distance(to: ideal))
        let distanceLessPrecise = Double(round(100*distance)/100)
        return CGFloat(1 / distanceLessPrecise)
    }
    
    private static func newPlanet(water: CGFloat, atmosphere: CGFloat, energy: CGFloat, nutrientCirculation: CGFloat) -> Planet{
        var newPlanet = Planet()
        newPlanet.water = water
        newPlanet.atmosphere = atmosphere
        newPlanet.energy = energy
        newPlanet.nutrientCirculation = nutrientCirculation
        return newPlanet
    }
    
    public func crossover(otherPlanet: Planet) -> Planet{
        var water: CGFloat = 0.0
        var atmosphere: CGFloat = 0.0
        var energy: CGFloat = 0.0
        var nutrientCirculation: CGFloat = 0.0
        
        if getAttFitness(value: self.water, ideal: 0.7) > getAttFitness(value: otherPlanet.water, ideal: 0.7) {
            water = self.water
        } else {
            water = otherPlanet.water
        }
        
        if getAttFitness(value: self.atmosphere, ideal: 0.7) > getAttFitness(value: otherPlanet.atmosphere, ideal: 0.5) {
            atmosphere = self.atmosphere
        } else {
            atmosphere = otherPlanet.atmosphere
        }
        
        if getAttFitness(value: self.energy, ideal: 0.7) > getAttFitness(value: otherPlanet.energy, ideal: 0.5) {
            energy = self.energy
        } else {
            energy = otherPlanet.energy
        }
        
        if getAttFitness(value: self.nutrientCirculation, ideal: 0.7) > getAttFitness(value: otherPlanet.nutrientCirculation, ideal: 0.8) {
            nutrientCirculation = self.nutrientCirculation
        } else {
            nutrientCirculation = otherPlanet.nutrientCirculation
        }
        
        var newPlanet = Planet.newPlanet(water: water, atmosphere: atmosphere, energy: energy, nutrientCirculation: nutrientCirculation)
        
        newPlanet.mutate()
        
        newPlanet.generateStyle()
        
        return newPlanet
    }
    
    mutating func mutate() {
        let willMutate: Bool = CGFloat.random(in: 0...1) > 0.7
        if !willMutate { return }
        
        switch Int.random(in: 1...4) {
            case 1:
                self.water = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
            case 2:
                self.atmosphere = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
            case 3:
                self.energy = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
            case 4:
                self.nutrientCirculation = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
            default:
                return
        }
        
    }
}
