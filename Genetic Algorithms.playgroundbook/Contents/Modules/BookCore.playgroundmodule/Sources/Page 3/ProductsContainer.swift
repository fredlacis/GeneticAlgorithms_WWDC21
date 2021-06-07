//
//  ProductsContainer.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 16/04/21.
//

import SwiftUI

struct Product {
    
    enum ProductName: String, CaseIterable {
        case IPhone =               "Box_IPhone"
        case IPhoneWithCharger =    "Box_Charger"
        case IPadPro =              "Box_IPadPro"
        case AppleWatch =           "Box_Watch"
        case MacBookPro =           "Box_MacBookPro"
        case AirPodsMax =           "Box_AirPodsMax"
    }
    
    var name: ProductName
    var weight: Int
    var value: Int
}

struct ProductsContainer: View {
    
    let productsSet: [Product] = [
        Product(name: .IPhone,             weight: 230,    value: 1100),
        Product(name: .IPhoneWithCharger,  weight: 350,    value: 1120),
        Product(name: .IPadPro,            weight: 650,    value: 1000),
        Product(name: .AppleWatch,         weight: 180,     value: 400),
        Product(name: .MacBookPro,         weight: 2000,   value: 2400),
        Product(name: .AirPodsMax,         weight: 400,    value: 550)
    ]
    
    var products: [(Product, Int)]
    
    let containerLimit = 20000000
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    
    @State var containerGeometry = CGRect()
    @State var hideText = false
    
    init(products receivedProducts: [(Product, Int)] = []) {
        self.products = []
        if !receivedProducts.isEmpty {
            self.products = receivedProducts
        } else {
            while true {
                
                let newProduct = productsSet.randomElement()!
                
                if products.contains(where: {$0.0.name == newProduct.name}) {
                    continue
                } else {
                    let currentWeight = products.reduce(0) {(result, next) -> Int in
                        return result + (next.0.weight * next.1)
                    }
                    if currentWeight + newProduct.weight > containerLimit {
                        self.products.append((newProduct, 0))
                    } else {
                        let newLimit = containerLimit - currentWeight
                        self.products.append((newProduct, Int.random(in: 0...Int(newLimit/newProduct.weight))))
                    }
                }
                
                if products.count == 6 {
                    self.products.sort {
                        $0.0.name.rawValue > $1.0.name.rawValue
                    }
                    break
                }
            }
        }
    }
    
    var body: some View {
       bigView()
    }
    
    func bigView() -> some View {
        ZStack {
            Image("Container")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(Color.clear.modifier(GeometryGetterMod(rect: $containerGeometry)))
            VStack {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(products.indices, id: \.self) { i in
                        HStack {
                            Image(products[i].0.name.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: containerGeometry.width/6, height: containerGeometry.width/6)
                                .padding(.vertical, 8)
                            (
                                Text("×")
                                    .font(.custom("Montserrat-Bold", size: containerGeometry.width/26))
                                +
                                Text("\(normalizeInt(products[i].1))")
                                    .font(.custom("Montserrat-Bold", size: containerGeometry.width/25))
                            )
                        }
                        .frame(width: containerGeometry.width/3 - 20)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(15)
                    }
                }
                .padding()
                if !hideText {
                    Text("Weight: \(normalizeInt(totalWeight())) | Value: \(normalizeInt(totalValue()))")
                        .font(.custom("Montserrat-Bold", size: 20))
                }
            }
        }
    }
    
    func smallView() -> some View {
        VStack {
            VStack {
                ForEach(products.indices, id: \.self) { i in
                    HStack {
                        Spacer()
                        Image(products[i].0.name.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                            .padding(.vertical, 2)
                        (
                            Text("×")
                                .font(.custom("Montserrat-Bold", size: 12))
                            +
                            Text("\(normalizeInt(products[i].1))")
                                .font(.custom("Montserrat-Bold", size: 15))
                        )
                        Spacer()
                    }
                }
            }.padding(.top, 4)
            Divider().colorScheme(.light)
            Text("Weight: " + normalizeInt(totalWeight()))
                .font(.custom("Montserrat-Bold", size: 15))
            Text("Value: " + normalizeInt(totalValue()))
                .font(.custom("Montserrat-Bold", size: 15))
                .padding(.bottom, 4)
        }
        .background(Color.white.opacity(0.5))
        .cornerRadius(15)
    }
    
    func normalizeInt(_ int: Int) -> String {
        if int > 1000 {
            return "\(Int(int/1000))K"
        } else {
            return "\(int)"
        }
    }
    
    func totalWeight() -> Int {
        return products.reduce(0) {(result, next) -> Int in
            return result + (next.0.weight * next.1)
        }
    }
    
    func totalValue() -> Int {
        return products.reduce(0) {(result, next) -> Int in
            return result + (next.0.value * next.1)
        }
    }
    
    func getFitness() -> Int {
        return self.totalWeight() > containerLimit ? 0 : self.totalValue()
    }
    
    func crossover(otherProductsContainer other: ProductsContainer) -> ProductsContainer {
        let crossoverPoint = Int.random(in: 0...5)
        var slice1 = Array(self.products[0..<crossoverPoint])
        let slice2 = Array(other.products[crossoverPoint..<6])
        slice1.append(contentsOf: slice2)
        return ProductsContainer(products: slice1)
    }
    
    mutating func mutate() {
        if Int.random(in: 0...1) != 0 {
            let index = Int.random(in: 0...5)
            let index2 = Int.random(in: 0...5)
            let aux = self.products[index].1
            self.products[index].1 = self.products[index2].1
            self.products[index2].1 = aux
        }
    }
}
