//
//  Container.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 30/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct Container<Content: View>: View {
    
    @State private var viewGeometry: CGRect = CGRect()
    
    @State private var spinBottomRightBol: Bool = false
    
    @State private var spinMiddleRightBol: Bool = false
    
    @State private var tilt: Bool = false
    
    var foreverAnimation: Animation {
        Animation.easeInOut(duration: 20.0)
            .repeatForever(autoreverses: true)
    }
    
    var slowForeverAnimation: Animation {
        Animation.linear(duration: 200.0)
            .repeatForever(autoreverses: true)
    }
    
    var background: Color = Color(UIColor(hex: "#1F3944")!)

    let content: () -> Content
    
    var body: some View {
        ZStack(alignment: .center) {
            self.background.edgesIgnoringSafeArea(.all)
            
            backgroundView
            
            content()
        }
        .overlay(Color.clear.modifier(GeometryGetterMod(rect: $viewGeometry)))
    }
    
    private var backgroundView: some View {
        Group {
            //Rectangle 4
            LinearGradient( gradient: Gradient(
                    stops: [
                        .init(color: Color(#colorLiteral(red: 0.12156862765550613, green: 0.2235294133424759, blue: 0.2666666805744171, alpha: 1)), location: 0),
                        .init(color: Color(#colorLiteral(red: 0.16470588743686676, green: 0.3960784375667572, blue: 0.501960813999176, alpha: 1)), location: 0.6958648562431335),
                        .init(color: Color(#colorLiteral(red: 0.3298090100288391, green: 0.5523333549499512, blue: 0.6541666388511658, alpha: 1)), location: 1)
                    ]),
                    startPoint: UnitPoint(x: 0, y: 1),
                    endPoint: UnitPoint(x: 1.000000059604643, y: 2.9490563990819396e-8)
            )
            .edgesIgnoringSafeArea(.all)
            
            Image(uiImage: #imageLiteral(resourceName: "Big_Blob_2"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 500)
                .rotationEffect(.degrees(spinMiddleRightBol ? 360 : 0))
                .animation(slowForeverAnimation)
                .onAppear() {
                    self.spinMiddleRightBol.toggle()
                }
                .scaleEffect(1)
                .offset(x: -viewGeometry.width/2, y: 0)
            
            Image(uiImage: #imageLiteral(resourceName: "Big_Blob"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 360)
                .rotationEffect(.degrees(spinBottomRightBol ? 0 : 360))
                .animation(foreverAnimation)
                .onAppear() {
                    self.spinBottomRightBol.toggle()
                }
                .scaleEffect(1)
                .offset(x: viewGeometry.width/2 - 50, y: viewGeometry.height/2 - 50)
            
            
            Image(uiImage: #imageLiteral(resourceName: "Moon"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 420, height: 420)
                .offset(x: viewGeometry.width/2 - 50, y: -viewGeometry.height/2)
            
            Image(uiImage: #imageLiteral(resourceName: "DNA"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 600)
                .rotationEffect(.degrees(tilt ? 0 : -15))
                .animation(foreverAnimation)
                .onAppear() {
                    self.tilt.toggle()
                }
                .scaleEffect(1)
                .offset(x: -viewGeometry.width/2 + 60, y: viewGeometry.height/2 - 50)
            
        }
    }
}

struct Container_Previews: PreviewProvider {
    static var previews: some View {
        Container {
            Text("Teste")
        }
    }
}
