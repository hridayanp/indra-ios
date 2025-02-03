//
//  AlertsView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import SwiftUI

struct AlertsView: View {
    @AppStorage("location") private var selectedLocation: String = "Select Location"
    
    
    
    var body: some View {
        BaseView {
            VStack {
                // Add the HeaderView at the top
                HeaderView()
                
                // Rest of the content
                Text("Alerts")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Spacer()
                
                // Display the selected location from app storage
                Text("Location: \(selectedLocation)")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding()
            }
            .padding(.horizontal, 10)
            .padding(.top, -10)
            .navigationTitle("Alerts")
        }
    }
}

#Preview {
    AlertsView()
}
