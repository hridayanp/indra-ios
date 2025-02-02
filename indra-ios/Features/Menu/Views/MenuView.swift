//
//  MenuView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import SwiftUI

// Main Menu View with Cards
struct MenuView: View {
    var body: some View {
        ZStack {
            // Background color for NavigationView
            Color(hex: "#0B1D29")
                .edgesIgnoringSafeArea(.all) // Ensure full background coverage
            
            NavigationView {
                VStack(spacing: 20) {
                    // Title
                    Text("Menu")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20) // Adds spacing from the top
                    
                    // Card for News
                    NavigationLink(
                        destination: ContentView(content: "News")) {
                            CardView(title: "News", icon: "newspaper.fill")
                        }
                    
                    // Card for Settings
                    NavigationLink(
                        destination: ContentView(content: "Settings")) {
                            CardView(title: "Settings", icon: "gearshape.fill")
                        }
                    
                    // Card for Profile
                    NavigationLink(
                        destination: ContentView(content: "Profile")) {
                            CardView(title: "Profile", icon: "person.fill")
                        }
                    
                    Spacer() // Pushes content to take full height
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 16)
                .background(Color(hex: "#0B1D29")) // Apply the background inside NavigationView too
                .navigationBarHidden(true) // Hide the default navigation bar
            }
            .navigationViewStyle(StackNavigationViewStyle()) // Proper behavior on iPads
        }
    }
}


// Card View for the Menu Items
struct CardView: View {
    var title: String
    var icon: String // New property to pass icon name
    
    var body: some View {
        HStack {
            // Icon
            Image(systemName: icon) // Use system icons from SF Symbols
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
                .padding(.leading, 15)
            
            // Title Text
            Text(title)
                .font(.title2)
                .foregroundColor(.white)
                .padding(.leading, 10)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .background(Color.clear) // Transparent background
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "#d8d8d8"), lineWidth: 1) // White border with 1px thickness
        )
        .padding(.vertical, 5)
    }
}

struct ContentView: View {
    var content: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        BaseView {
            VStack {
                Text(content)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Spacer()
                
                if content == "News" {
                    NewsView()
                }
            }
            .navigationBarTitle(content, displayMode: .inline)
            .navigationBarBackButtonHidden(true) // Hide the default back button
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left.circle.fill") // Left arrow icon
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white) // Icon color
                            .padding(10)
                    }
                }
            }
        }
    }
}


#Preview {
    MenuView()
}
