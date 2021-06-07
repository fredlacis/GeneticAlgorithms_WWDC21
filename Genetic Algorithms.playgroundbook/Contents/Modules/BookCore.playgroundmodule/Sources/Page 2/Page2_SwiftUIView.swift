//
//  Page2_SwiftUIView.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 13/04/21.
//

import SwiftUI
import PlaygroundSupport
import AVFoundation

struct Page2_SwiftUIView: View {
    
    enum Parts: CaseIterable {
        case Part1
        case Part2
        case Part3
        case Part4
    }
    
    @State private var planets: [Planet] = []
    
    @State private var parts: [Any] = []
    
    @State private var part: Parts = .Part1
    
    @State private var isFirstRun: Bool = true
    
    var body: some View {
        Container {
                VStack {
                    InvisibleMusicPlayer(music: "ToPassTime-Godmode")
                    if !parts.isEmpty {
                        Spacer()
                        
                        currentPart
                        
                        Spacer()
                        
                        bottomButtons
                    }
                }
                .foregroundColor(.white)
        }.onAppear() {
            self.parts = [Part1(planets: $planets), Part2(planets: $planets), Part3(planets: $planets), Part4(planets: $planets)]
        }
    }
    
    var currentPart: some View {
        Group {
            switch part {
            case .Part1:
                (parts[0] as! Part1)
                    .animation(.linear(duration: 0.5))
                
            case .Part2:
                parts[1] as! Part2
                
            case .Part3:
                parts[2] as! Part3
                
            case .Part4:
                (parts[3] as! Part4)
                    .onAppear(perform: sendCompletitionMessage)
                
            }
        }
    }
    
    var bottomButtons: some View {
        HStack {
            if part == Parts.Part1 && isFirstRun {
                CustomButton(label: "New population", action: newPopulation)
            }
            CustomButton(label: "Next", action: nextPart)
        }
    }
    
    func newPopulation() {
        withAnimation(.linear(duration: 0.3)){
            (parts[0] as! Part1).generateRandomPlanets()
        }
    }
    
    func nextPart() {
        withAnimation {
            self.part = self.part.next()
        }
    }
    
    func sendCompletitionMessage() {
        if isFirstRun {
            PlaygroundPage.current.assessmentStatus = .pass(message:
                "[Click here to go to the next page!](@next) Or keep clicking on \"Next\" to see your planets getting better and better!"
            )
            isFirstRun = false
        }
    }
}
