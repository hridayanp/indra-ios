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
                Image("indra-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .foregroundColor(.white)
                
                CustomButton(title: "Login", type: .primary) {
                    router.navigate(to: .authSelection(.login))
                }
                
                
                CustomButton(title: "Register", type: .secondary) {
                    router.navigate(to: .authSelection(.signup))
                }
                
                
                Button("Continue as Guest") {
                    router.navigate(to: .mainTabs)
                }
                .foregroundColor(.blue)
            }
            .padding()
        }
        
    }
}

#Preview {
    AuthView()
}
