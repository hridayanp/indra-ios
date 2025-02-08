//
//  AlertsView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import SwiftUI

struct AlertsView: View {
    @AppStorage("location") private var selectedLocation: String = "Select Location"
    @State private var selectedTab: AlertTab = .alertsSent
    
    enum AlertTab {
        case alertsSent
        case manageAlerts
        
    }
    
    var body: some View {
        BaseView {
            VStack(spacing: 0) {
                // Header View
                HeaderView()
                
                // Tab Buttons
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        tabButton(title: "Alerts Sent", tab: .alertsSent)
                        tabButton(title: "Manage Alerts", tab: .manageAlerts)
                    }
                    
                    // Single continuous underline
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.gray)
                        .overlay(
                            GeometryReader { geo in
                                Rectangle()
                                    .frame(width: geo.size.width / 2)
                                    .foregroundColor(.white)
                                    .offset(x: selectedTab == .alertsSent ? 0 : geo.size.width / 2)
                                    .animation(.easeInOut(duration: 0.3), value: selectedTab)
                            }
                        )
                }
                .padding(.top, 10)
                
                // Scrollable Content Area (No Gap)
                ScrollView {
                    VStack(spacing: 10) { // Adjust spacing for seamless transition
                        if selectedTab == .manageAlerts {
                            Text("Manage")
                        } else {
                            AlertsSentView()
                        }
                        
                        Spacer()
                        
                        // Selected Location Display
                        Text("Location: \(selectedLocation)")
                            .font(.title3)
                            .foregroundStyle(.white)
                            .padding(.bottom, 20)
                            .frame(alignment: .bottom)
                    }
                    .padding(.top, 10) // Slight padding to prevent direct overlap
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .padding(.horizontal, 10)
            .navigationTitle("Alerts")
        }
    }
    
    // Tab Button Component
    private func tabButton(title: String, tab: AlertTab) -> some View {
        Button(action: {
            withAnimation {
                selectedTab = tab
            }
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
        }
    }
}

#Preview {
    AlertsView()
}
