//
//  MainTabsView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var router: AppRouter
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color(hex: "#0B1D29") ) // #0B1D29
        appearance.stackedItemSpacing = 4  // Adjust spacing between icon & text
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "TabsUnselected")
    }
    
    var body: some View {
        TabView {
            ForecastView()
                .tabItem {
                    Label("Forecast", systemImage: "cloud.sun.fill")
                        .labelStyle(VerticalLabelStyle())
                }
            
            AlertsView()
                .tabItem {
                    Label("Alerts", systemImage: "bell.fill")
                        .labelStyle(VerticalLabelStyle())
                }
            
            MenuView(authViewModel: AuthViewModel())
                .tabItem {
                    Label("Settings", systemImage: "square.grid.2x2")
                        .labelStyle(VerticalLabelStyle())
                }
        }
        .accentColor(.white) // Selected tab color
        .background(Color(hex: "#0B1D29")) // Background color
        .edgesIgnoringSafeArea(.bottom)
    }
}

// Custom Vertical Label Style to align icons & text properly
struct VerticalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 2) { // Adjust spacing for balance
            configuration.icon
                .font(.system(size: 22)) // Adjust icon size
            configuration.title
                .font(.system(size: 14)) // Match UI spec
                .fontWeight(.medium)
        }
    }
}

#Preview {
    MainTabView()
}
