//
//  ContentView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var router = AppRouter()
    
    var body: some View {
        
        NavigationView {
            VStack {
                if let route = router.currentRoute {
                    switch route {
                    case .authSelection(let tab):
                        AuthSelectionView(defaultTab: tab)
                    case .home:
                        Text("Home Screen")
                    }
                } else {
                    AuthView()
                }
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    MainView()
}
