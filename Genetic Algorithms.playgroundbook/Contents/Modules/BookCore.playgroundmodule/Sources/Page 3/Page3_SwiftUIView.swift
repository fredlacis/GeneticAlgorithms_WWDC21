//
//  Page3_SwiftUIView.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 16/04/21.
//

import SwiftUI
import PlaygroundSupport

public struct Page3_SwiftUIView: View {
    
    @State var productsContainers: [ProductsContainer] = []
    
    @State var bestContainer: ProductsContainer?
    
    @State var currentGeneration = 1
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
    
    var numberOfExecutions: Int
    var populationSize: Int
    var executionSpeed: CGFloat
    
    public init(numberOfExecutions: Int = 200, populationSize: Int = 500, executionSpeed: CGFloat = 0.1) {
        self.numberOfExecutions = numberOfExecutions
        self.populationSize = populationSize
        self.executionSpeed = executionSpeed
    }
    
    public var body: some View {
        Container {
           VStack {
                InvisibleMusicPlayer(music: "BrassOrchid-BobbyRichards")
                Text("Population size: \(populationSize)")
                    .font(.custom("Montserrat-Regular", size: 24))
                Text("Generation: \(self.currentGeneration)/\(self.numberOfExecutions)")
                    .font(.custom("Montserrat-Regular", size: 24))
            
                if let bestContainer = bestContainer {
                    ZStack(alignment: .topLeading){
                        bestContainer
                            .padding()
                            .frame(maxWidth: 900)
                            .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 0)
                        Text("1º")
                            .font(.custom("Montserrat-Bold", size: 30))
                            .padding(.leading, 12)
                            .padding(.top, 8)
                    }.padding(.bottom)
                }
                
                if productsContainers.count >= 7 {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(1..<7) {i in
                            ZStack(alignment: .topLeading){
                                Text("\(i+1)º")
                                    .font(.custom("Montserrat-Bold", size: 20))
                                    .padding(.leading, 12)
                                    .padding(.top, 8)
                                productsContainers[i]
                                    .smallView()
                                    .padding(4)
                                    .frame(maxWidth: 250)
                                    .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 0)
                            }
                        }
                    }.frame(maxWidth: 868)
                }
            
            }.onAppear() {
                for _ in 0...populationSize {
                    self.productsContainers.append(ProductsContainer())
                }
                runAlgorithm()
            }
           .foregroundColor(.white)
        }
    }
    
    func sortByFitness() {
        productsContainers.sort() {$0.getFitness() > $1.getFitness()}
        bestContainer = productsContainers[0]
    }
    
    func selection() {
        sortByFitness()
        
        var chosenPart:[ProductsContainer] = []
        
        if Int.random(in: 0...1) != 0 {
            let onePercent = Int(self.productsContainers.count/100)
            let maxIndex = max(Int(self.productsContainers.count - (onePercent * self.currentGeneration)), Int(self.productsContainers.count/2))
            chosenPart = Array(self.productsContainers[0..<maxIndex])
        } else {
            chosenPart = self.productsContainers
        }
        
        var matingPool:[ProductsContainer] = []
        let biggestFitness = CGFloat(self.productsContainers.first!.getFitness())
        for element in chosenPart {
            let fitness = CGFloat(element.getFitness()).map(from: 0...biggestFitness, to: 0...1)
            let numberOfElements = Int(floor(fitness * 100))
            for _ in 0...numberOfElements {
                matingPool.append(element)
            }
        }
        
        for i in 0...populationSize {
            let partnerA = matingPool.randomElement()!
            let partnerB = matingPool.randomElement()!
            
            var child: ProductsContainer = ProductsContainer()
            for i in 0...10 {
                child = partnerA.crossover(otherProductsContainer: partnerB)
                child.mutate()
                if child.getFitness() == 0 {
                    if i == 10 {
                        child = [partnerA, partnerB].randomElement()!
                    }
                } else {
                    break
                }
            }
            
            self.productsContainers[i] = self.productsContainers[i].getFitness() < child.getFitness() ? child : self.productsContainers[i]
        }
        
        self.currentGeneration += 1
    }
    
    func runAlgorithm() {
        selection()
        sortByFitness()
        if self.currentGeneration < self.numberOfExecutions {
            DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.milliseconds(Int(executionSpeed*1000))) {
                withAnimation {
                    runAlgorithm()
                }
            }
        } else {
            PlaygroundPage.current.assessmentStatus = .pass(message: "It was great having you here! I hope you had a great time and learned a little bit about Genetic Algorithms!")
        }
    }
}

struct Page3_SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Page3_SwiftUIView()
    }
}
