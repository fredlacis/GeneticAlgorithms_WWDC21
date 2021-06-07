//
//  Part3.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 13/04/21.
//

import SwiftUI

struct Part3: View {
    
    @Binding var planets: [Planet]
        
    @State private var planetSize = CGSize()
    
    @State private var crossoverImageGeometry: CGRect = CGRect()
    
    @State private var beat = false
    
    @State private var crossovers: [(planet1: Planet, planet2: Planet, crossover: Planet)] = []
    
    @State private var displayedCrossoverIndex: Int = 0
    
    var foreverAnimation: Animation {
        Animation.easeInOut(duration: 3.0)
            .repeatForever(autoreverses: true)
    }
    
    
    var body: some View {
        VStack {
            Title("3º: Crossover")
            HStack {
                previousButton
                crossOver
                nextButton
            }
            Text("\(displayedCrossoverIndex + 1)")
                .font(.custom("Montserrat-Bold", size: 20))
        }
        .padding(.horizontal)
        .onAppear() {
            planetSize = planets.first!.frame
        }
    }
    
    var previousButton: some View {
        Button(action: {
            withAnimation {
                if displayedCrossoverIndex > 0 {
                    displayedCrossoverIndex -= 1
                } else {
                    displayedCrossoverIndex = crossovers.count - 1
                }
            }
        }) {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .padding()
        }
        .background(Color(UIColor(hex: "#59AFAC")!))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 0)
    }
    
    var nextButton: some View {
        Button(action: {
            withAnimation {
                if displayedCrossoverIndex < crossovers.count - 1 {
                    displayedCrossoverIndex += 1
                } else {
                    displayedCrossoverIndex = 0
                }
            }
        }) {
            Image(systemName: "chevron.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .padding()
        }
        .background(Color(UIColor(hex: "#59AFAC")!))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 0)
    }
    
    var crossOver: some View {
        VStack {
            if !crossovers.isEmpty {
                HStack(alignment: .top) {
                    crossovers[displayedCrossoverIndex].planet1
                VStack {
                    ZStack(alignment: .top){
                        Image("Crossover")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 0)
                            .overlay(Color.clear.modifier(GeometryGetterMod(rect: $crossoverImageGeometry)))
                        Group {
                            Image(systemName: "arrow.down.heart.fill")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .background(Color.white.clipShape(Circle().inset(by: 11)))
                                .foregroundColor(.red)
                                .buttonStyle(PlainButtonStyle())
                                .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 0)
                                .scaleEffect(beat ? 0.9 : 1.2)
                                .animation(foreverAnimation)
                        }
                        .scaleEffect(1)
                        .padding(.top, crossoverImageGeometry.height * 0.10)
                        .onAppear(){
                            beat.toggle()
                        }
                    }
                    .padding(.top, planetSize.height/2)

                    crossovers[displayedCrossoverIndex].crossover
                }
                    crossovers[displayedCrossoverIndex].planet2
            }
            }
        }.onAppear(perform: createCrossoverPopulation)
    }
    
    func createCrossoverPopulation() {
        for planet in planets {
            for planet2 in planets {
                crossovers.append((planet, planet2, planet.crossover(otherPlanet: planet2)))
            }
        }
        planets = []
        for crossover in crossovers {
            planets.append(crossover.crossover)
        }
        planets.sort(by: { $0.getFitness() > $1.getFitness() })
        crossovers.shuffle()
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
