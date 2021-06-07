//
//  Page1_SwiftUIView.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 09/04/21.
//

import SwiftUI
import PlaygroundSupport

public struct Page1_SwiftUIView: View{
    
    enum Scenes: Int, CaseIterable {
        case StartScene = 0
        case DisplayDarwin = 1
        case Introduction = 2
        case Introduction2 = 3
        case Introduction3 = 4
        case DisplayMissionDescription = 5
        case DisplayTurtleGrid = 6
        case DisplayTurtleResult = 7
        case DisplayTurtleResult2 = 8
        case End = 9
    }
    
    enum DialogTexts: String {
        case Introduction = "Hey there! I'm Charles Darwin, one of the most influential scientist when the matter is EVOLUTION!"
        case Introduction2 = "Today we are going to talk about Natural Selection, one of the foundations of the Theory of Evolution that was a strong inspiration for the creation of Genetic Algorithms!"
        case Introduction3 = "To understand how it works a little better, I will propose a game."
        case MissionDescription = "Your mission is to find out which of the following species will best adapt to the given habitat. Are you ready?"
        case FirstScenario = "Which of these turtles would adapt better to an island with difficult access to vegetation?\nPay attention to its physical characteristics.\nClick to select them."
        case FirstScenarioResult = "Natural Selection makes sure that only the best adapted can survive and then reproduce."
        case FirstScenarioResult2 = "I observed this case in September 1835 at the Chatham Island, part of the Galápagos archipelago."
    }
    
    @State private var dialogBoxGeometry: CGRect = CGRect()
    
    @State private var viewGeometry: CGRect = CGRect()
    
    @State private var spin: Bool = false
    
    @State private var sceneCount: Scenes = .StartScene
    
    @State private var selectedAnimals: [Int] = []
    
    @State private var displayTip: Bool = false
    
    @State private var nextEnabled: Bool = true
    
    let maxTurtleWidth: CGFloat = 145
        
    var foreverAnimation: Animation {
            Animation.easeInOut(duration: 20.0)
                .repeatForever(autoreverses: true)
        }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var turtles: [String]
    var turtleColor: [Color]
    var blobs:   [String]
    
    init() {
        self.turtles = []
        self.turtleColor = []
        self.blobs = []
        
        for _ in 1...3 {
            turtles.append("Turtle_1")
            turtles.append("Turtle_2")
            turtles.append("Turtle_3")
            for _ in 1...3 {
                blobs.append("Blob_\(Int.random(in: 1...3))")
                turtleColor.append(Color(UIColor.randomForTurtle()))
            }
        }
        
        turtles.shuffle()
        blobs.shuffle()
    }
    
    func passMessage() {
        PlaygroundPage.current.assessmentStatus = .pass(message: "[Click here to go to the next page!](@next)")
    }
    
    public var body: some View {
        Container {
            ZStack {
                
                InvisibleMusicPlayer(music: "FogMist-TrackTribe")
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    if self.sceneCount != Scenes.End {
                        Text("Natural Selection")
                            .font(.custom("Montserrat-Regular", size: 30))
                            .padding(.bottom)
                    }
                    
                    if self.sceneCount == Scenes.DisplayTurtleGrid {
                        turtleGrid
                    } else if self.sceneCount == Scenes.DisplayTurtleResult || self.sceneCount == Scenes.DisplayTurtleResult2 {
                        turtleResult
                    } else if self.sceneCount == Scenes.End {
                        Text("Now that you understand how Natural Selection works, lets see how it is applied to a Genetic Algorithm.")
                            .font(.custom("Montserrat-Regular", size: 30))
                            .padding(.bottom)
                        Text("Go to the next page!")
                            .font(.custom("Montserrat-Regular", size: 20))
                            .padding(.bottom)
                            .onAppear(perform: passMessage)
                    }
                    
                    
                    if sceneCount.rawValue < Scenes.End.rawValue {
                        dialogBox
                            .padding(.top, sceneCount == Scenes.DisplayTurtleGrid ? -30 : 0)
                    }
                    
                    
                    
                    if self.sceneCount.rawValue >= Scenes.Introduction.rawValue && sceneCount.rawValue < Scenes.End.rawValue {
                        bottomButtons
                    }
                    
                }
                .padding()
                
                if displayTip {
                    tipView
                }
            }
            .frame(maxWidth: 900)
            .foregroundColor(.white)
            .overlay(Color.clear.modifier(GeometryGetterMod(rect: $viewGeometry)))
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        self.sceneCount = .DisplayDarwin
                    }
                }
            }
        }
    }
    
    private var turtleGrid: some View {
        LazyVGrid(columns: columns, spacing: 10){
            ForEach(turtles.indices, id: \.self) { i in
                Button(action: {
                    if selectedAnimals.contains(i), let index = selectedAnimals.firstIndex(of: i){
                        selectedAnimals.remove(at: index)
                    } else if selectedAnimals.count < 3 {
                        selectedAnimals.append(i)
                    }
                    
                    if selectedAnimals.count < 3 {
                        nextEnabled = false
                    } else {
                        nextEnabled = true
                    }
                }){
                    ZStack() {
                        
                        Image(blobs[i])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: maxTurtleWidth)

                        Image(turtles[i])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: maxTurtleWidth)
                            .shadow(color: Color.black.opacity(0.7), radius: 20, x: 0, y: 0)

                        Image(turtles[i])
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: maxTurtleWidth)
                            .foregroundColor(turtleColor[i])
                            .blendMode(.overlay)
                            .opacity(0.8)
                        
                        if selectedAnimals.contains(i){
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .background(Color.white.clipShape(Circle().inset(by: 1)))
                                .foregroundColor(Color.green)
                                .buttonStyle(PlainButtonStyle())
                                .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 0)
                                .offset(x: 50, y: -50)
                        }
                    }
                }
            }
        }
        .onAppear(){
            nextEnabled = false
        }
    }
    
    private var turtleResult: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    ForEach(selectedAnimals, id: \.self){ i in
                        ZStack() {
                            
                            Image(blobs[i])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: maxTurtleWidth)

                            Image(turtles[i])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: maxTurtleWidth)
                                .shadow(color: Color.black.opacity(0.7), radius: 20, x: 0, y: 0)

                            Image(turtles[i])
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: maxTurtleWidth)
                                .foregroundColor(turtleColor[i])
                                .blendMode(.overlay)
                                .opacity(0.8)
                            
                            if(turtles[i] == "Turtle_1"){
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .background(Color.white.clipShape(Circle().inset(by: 1)))
                                    .foregroundColor(Color.green)
                                    .buttonStyle(PlainButtonStyle())
                                    .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 0)
                                    .offset(x: 50, y: -50)
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .background(Color.white.clipShape(Circle().inset(by: 1)))
                                    .foregroundColor(Color.red)
                                    .buttonStyle(PlainButtonStyle())
                                    .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 0)
                                    .offset(x: 50, y: -50)
                            }
                        }
                    }
                    Spacer()
                }
                if(selectedAnimals.elementsEqual(["Turtle_1", "Turtle_1", "Turtle_1"], by: {(i, s) in return turtles[i]==s}) ){
                    Text("You got it!")
                        .font(.custom("Montserrat-Bold", size: 30))
                        .padding()
                } else {
                    Text("You almost got it!")
                        .font(.custom("Montserrat-Bold", size: 30))
                        .padding()
                }
                if sceneCount == Scenes.DisplayTurtleResult2 {
                    HStack {
                        Image("Darwin_Turtle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 180)
                        Image("Turtle_1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 180)
                    }
                }
            }
        }
    }
    
    private var dialogBox: some View {
        ZStack(alignment: .center){
            if sceneCount.rawValue >= Scenes.Introduction.rawValue {
                ZStack(alignment: .top){
                    BlurView(style: .light)
                        .overlay(
                            Image(uiImage: #imageLiteral(resourceName: "Frosty_Texture"))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .blendMode(.overlay)
                                .opacity(0.1)
                        )
                        .cornerRadius(15)
                        .frame(height: dialogBoxGeometry.height - 40)
                    VStack (alignment: .leading, spacing: 0){
                        Text("Charles Darwin")
                            .font(.custom("Montserrat-Bold", size: 30))
                            .padding(.top)
                        
                        switch sceneCount {
                            case Scenes.Introduction:
                                Text(DialogTexts.Introduction.rawValue)
                                    .font(.custom("Montserrat-Regular", size: 18))
                                    .tracking(0.8)
                                
                            case Scenes.Introduction2:
                                Text(DialogTexts.Introduction2.rawValue)
                                    .font(.custom("Montserrat-Regular", size: 18))
                                    .tracking(0.8)
                                
                            case Scenes.Introduction3:
                                Text(DialogTexts.Introduction3.rawValue)
                                    .font(.custom("Montserrat-Regular", size: 18))
                                    .tracking(0.8)
                                
                            case Scenes.DisplayMissionDescription:
                                Text(DialogTexts.MissionDescription.rawValue)
                                    .font(.custom("Montserrat-Regular", size: 18))
                                    .tracking(0.8)

                            case Scenes.DisplayTurtleGrid:
                                Text(DialogTexts.FirstScenario.rawValue)
                                    .font(.custom("Montserrat-Regular", size: 18))
                                    .tracking(0.8)
                                
                            case Scenes.DisplayTurtleResult:
                                Text(DialogTexts.FirstScenarioResult.rawValue)
                                    .font(.custom("Montserrat-Regular", size: 18))
                                    .tracking(0.8)
                                
                            case Scenes.DisplayTurtleResult2:
                                Text(DialogTexts.FirstScenarioResult2.rawValue)
                                    .font(.custom("Montserrat-Regular", size: 18))
                                    .tracking(0.8)

                            default:
                                EmptyView()
                        }
                        
                        
                    }
                    .padding(.leading, dialogBoxGeometry.width/2)
                    .padding(.trailing)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(Color.white.opacity(0.2), lineWidth: 2)
                )
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: -3.5)
                .padding(.leading, dialogBoxGeometry.width/2)
                .padding(.vertical)
            }
            
            if sceneCount.rawValue >= Scenes.DisplayDarwin.rawValue {
                HStack {
                    if sceneCount.rawValue == Scenes.DisplayDarwin.rawValue {
                        Spacer()
                    }
                    Image("Darwin_Hologram")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 240)
                        .overlay(Color.clear.modifier(GeometryGetterMod(rect: $dialogBoxGeometry)))
                    Spacer()
                }
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            self.sceneCount = self.sceneCount.next()
                        }
                    }
                }
            }
        }
    }
    
    private var bottomButtons: some View {
        ZStack {
            if self.sceneCount == Scenes.DisplayTurtleGrid {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        withAnimation{
                            self.displayTip.toggle()
                        }
                    }){
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .background(Color.white.clipShape(Circle().inset(by: 11)))
                            .foregroundColor(Color(UIColor(hex: "#59AFAC")!))
                            .buttonStyle(PlainButtonStyle())
                    }
                    .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 0)
                }
            }
            
            HStack {
                Spacer()
                
                CustomButton(label: "Next", action: {
                        withAnimation {
                            self.sceneCount = self.sceneCount.next()
                        }
                    }
                )
                .disabled(!nextEnabled)
                .opacity(nextEnabled ? 1.0 : 0.5)
                
                Spacer()
            }
            
        }
    }
    
    private var tipView: some View {
        ZStack {
            Color.black.opacity(0.8).edgesIgnoringSafeArea(.all)
            
            ZStack(alignment: .topTrailing){
                VStack(alignment: .leading, spacing: 0) {
                    Text("Need a tip?")
                        .font(.custom("Montserrat-Bold", size: 30))
                        .padding(.horizontal)
                        .padding(.top)
                    
                    if self.sceneCount == Scenes.DisplayTurtleGrid {
                        Text("I believe turtle with longer necks would be able to reach the difficult vegetation more easily.")
                            .font(.custom("Montserrat-Regular", size: 30))
                            .padding()
                    }
                    
                }
                .foregroundColor(Color(UIColor(hex: "#1F3944")!))
                .frame(width: viewGeometry.width - 50)
                .background(Color.white.opacity(0.8))
                .cornerRadius(15)
                
                Button(action: {
                    withAnimation{
                        self.displayTip.toggle()
                    }
                }){
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .background(Color.white.clipShape(Circle().inset(by: 1)))
                        .foregroundColor(Color.red)
                        .buttonStyle(PlainButtonStyle())
                }
                .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 0)
                .offset(x: 35/2, y: -35/2)
//                .position(x: viewGeometry.width - 50, y: viewGeometry.width/2)
            }
            
        }
    }
    
//    private var backgroundView: some View {
//        Group {
//            Color(UIColor(hex: "#1F3944")!)
//                .edgesIgnoringSafeArea(.all)
//
//            Image(uiImage: #imageLiteral(resourceName: "Big_Blob"))
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 350, height: 360)
//                .rotationEffect(.degrees(spin ? 0 : 360))
//                .animation(foreverAnimation)
//                .onAppear() {
//                    self.spin.toggle()
//                }
//                .scaleEffect(1)
//                .offset(x: viewGeometry.width/2 - 50, y: viewGeometry.height/2 - 50)
//
//
//            Image(uiImage: #imageLiteral(resourceName: "Moon"))
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 420, height: 420)
//                .offset(x: viewGeometry.width/2 - 50, y: -viewGeometry.height/2)
//
//        }
//    }
    
}

struct Page1_SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        Page1_SwiftUIView()
    }
}
