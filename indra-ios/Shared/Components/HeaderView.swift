//
//  HeaderView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 03/02/25.
//

import SwiftUI


struct HeaderView: View {
    @AppStorage("location") private var location: String = "Select Location"
    let locationOptions = ["Test 1", "Test 2", "Test 3"]
    
    var body: some View {
        VStack() {
            // First row: Logo and icon
            HStack {
                // Logo icon
                Image("indra-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 50)
                    .foregroundColor(.white)
                
                Spacer()
                
                // Right icon (for example, settings icon)
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.yellow)
            }
            .padding(.horizontal, 16)
            .background(Color.clear) // Transparent background for the header
            CustomDropdown(selectedItem: $location, options: locationOptions) { selectedLocation in
                // Handle the selected location, update if needed
                print("Location changed to: \(selectedLocation)")
            }
            .padding(.horizontal, 16)
        }
        
    }
}



// Preview
//#Preview {
//    HeaderView().background(.red)
//}
