//
//  MenuView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import SwiftUI

// Main Menu View with Cards
struct MenuView: View {
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            
            Color(hex: "#0B1D29")
                .edgesIgnoringSafeArea(.all)
            
            NavigationView {
                VStack(alignment: .leading, spacing: 20) {
                    // Title
                    Text("Menu")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
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
                    
                    Spacer()
                    
                    VStack {
                        // Other UI elements
                        Text(authViewModel.isLoggedIn ? "You are logged in" : "Logged out")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        
                        // Logout button
                        Button(action: {
                            authViewModel.logout()
                        }) {
                            Text("Logout")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                        .padding(.top, 20)
                    }
                    .padding()
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 16)
                .background(Color(hex: "#0B1D29"))
                .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
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
    @State private var isInDetailView = false
    
    var body: some View {
        BaseView {
            VStack {
                
                Spacer()
            
                if content == "News" {
                    NewsView(isInDetailView: $isInDetailView)
                }
                
                if content == "Profile" {
                    ProfileView(isInDetailView: $isInDetailView)
                }
            }
            .navigationBarBackButtonHidden(true) // Hide the default back button
            
            .toolbar {
                if !isInDetailView { // Show toolbar only when not in detail view
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack {
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "arrow.left.circle.fill") // Left arrow icon
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                            }
                            Text(content)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    MenuView(authViewModel: AuthViewModel())
}
