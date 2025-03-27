//
//  SplashScreen.swift
//  YooHoo
//
//  Created by Yonathan Handoyo on 27/03/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false // Mengontrol transisi ke tampilan utama
    @State private var opacity = 0.5 // Untuk animasi opacity
    
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
