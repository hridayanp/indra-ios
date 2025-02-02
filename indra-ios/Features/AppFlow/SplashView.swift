//
//  SplashView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 02/02/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var fadeOut = false // Controls fade-out animation
    @State private var scaleEffect = 1.0 // Controls scaling animation
    
    var body: some View {
        ZStack {
            if isActive {
                MainView() // Transition to main view
                    .transition(.opacity) // Fade in main view smoothly
            } else {
                VStack {
                    Image("indra-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 100)
                        .foregroundColor(.white)
                        .scaleEffect(scaleEffect)
                        .opacity(fadeOut ? 0 : 1)
                    
//                    Text("Indra Weather")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .padding(.top, 10)
//                        .scaleEffect(scaleEffect)
//                        .opacity(fadeOut ? 0 : 1)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex: "#0B1D29"))
                .ignoresSafeArea()
                .onAppear {
                    // Initial Animation (Scale Up Slightly)
                    withAnimation(.easeInOut(duration: 1.5)) {
                        scaleEffect = 1.2
                    }
                    
                    // Delay before transition
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        // Exit Animation (Scale Out and Fade)
                        withAnimation(.easeInOut(duration: 0.5)) {
                            scaleEffect = 1.5
                            fadeOut = true
                        }
                        
                        // After animation completes, transition to main view
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                isActive = true
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
