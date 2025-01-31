//
//  AuthView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var router: AppRouter
    
    
    var body: some View {
        BaseView {
            VStack(spacing: 20) {
                Text("Weather App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                CustomButton(title: "Login", type: .primary) {
                    router.navigate(to: .authSelection(.login))
                }
                
                
                CustomButton(title: "Register", type: .secondary) {
                    router.navigate(to: .authSelection(.signup))
                }
                
                
                Button("Continue as Guest") {
                    router.navigate(to: .home)
                }
                .foregroundColor(.blue)
            }
            .padding()
        }
        
    }
}

//#Preview {
//    AuthView()
//}
