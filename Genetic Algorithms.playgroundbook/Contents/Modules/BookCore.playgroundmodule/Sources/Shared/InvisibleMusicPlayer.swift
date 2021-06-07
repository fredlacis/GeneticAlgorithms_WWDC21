//
//  InvisibleMusicPlayer.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 18/04/21.
//

import SwiftUI
import AVFoundation

struct InvisibleMusicPlayer: View {
    
    @State var music: String
    
    @State var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        VStack{
            EmptyView()
        }
        .onAppear() {
            if let musicPath = Bundle.main.path(forResource: music, ofType: "mp3") {
                do {
                    let musicUrl = URL(fileURLWithPath: musicPath)
                    self.audioPlayer = try AVAudioPlayer(contentsOf: musicUrl)
                    if let audioPlayer = self.audioPlayer {
                        audioPlayer.numberOfLoops = -1
                        audioPlayer.volume = 0.1
                        audioPlayer.play()
                    }
                } catch {
                    return
                }
            }
        }
    }
}
