//
//  SplashScreen.swift
//  YooHoo
//
//  Created by Yonathan Handoyo on 27/03/25.
//

import SwiftUI
import AVFoundation

struct SplashScreenView: View {
    @State private var isActive = false // Mengontrol transisi ke tampilan utama
    @State private var opacity = 0.5 // Untuk animasi opacity
    @State private var audioPlayer: AVAudioPlayer?
    
    func playYooHooSound() {
        guard let path = Bundle.main.path(forResource: "yoohoo", ofType: "m4a") else{
                print("Sound file not found")
                return
        }
    
    let url = URL(fileURLWithPath: path)
    
    do{
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    } catch {
        print("Error playing sound: \(error)")
    }
}
    
    var body: some View {
        if isActive {
            MainTabView()
        } else {
            Image("Splash")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(opacity)
                .ignoresSafeArea()
                .onAppear {
                    playYooHooSound()
                    withAnimation(.easeIn(duration: 1.0)) {
                        self.opacity = 1.0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation(.easeOut(duration: 0.5)) {
                            self.isActive = true
                        }
                    }
                }
        }
    }
}

#Preview {
    SplashScreenView()
}
