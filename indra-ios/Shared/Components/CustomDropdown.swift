//
//  CustomDropdown.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 03/02/25.
//

import SwiftUI

struct CustomDropdown: View {
    @Binding var selectedItem: String
    let options: [String]
    let onItemSelected: (String) -> Void
    
    @State private var isDropdownOpen = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Selected item view (the dropdown toggle)
            HStack {
                // Title Text
                Text(selectedItem)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                
                Spacer()
                
                // Down arrow
                Image(systemName: "chevron.down")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.clear) // Transparent background
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "#d8d8d8"), lineWidth: 1) // White border with 1px thickness
            )
            .padding(.vertical, 5)
            .onTapGesture {
                withAnimation {
                    isDropdownOpen.toggle() // Toggle dropdown open/close when anywhere inside the view is clicked
                }
            }
            
            // Dropdown menu
            if isDropdownOpen {
                VStack(spacing: 0) {
                    ScrollView {
                        ForEach(options, id: \.self) { option in
                            VStack {
                                Text(option)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.clear)
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedItem = option
                                            onItemSelected(option) // Return selected option
                                            isDropdownOpen = false // Close the dropdown after selection
                                        }
                                    }
                                
                                Divider()
                                    .frame(height: 2)
                                    .background(Color(hex: "#d8d8d8"))
                            }
                        }
                    }
                    .frame(height: 150) // Fixed height for the dropdown menu
                    .background(Color.clear) // Transparent background
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(hex: "#d8d8d8"), lineWidth: 1) // Border similar to dropdown
                    )
                    .padding(.top, -1) // Remove the top gap, make it flush with the dropdown trigger
                    .transition(.move(edge: .top)) // Ensures the menu opens/close from top
                }
                .animation(.easeInOut(duration: 0.3), value: isDropdownOpen) // Smooth transition
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32) // Ensures full width except for padding
    }
}


//
//#Preview {
//    VStack {
//        // Using @State variable to bind selectedItem
//        CustomDropdown(
//            selectedItem: .constant("Select Location"), // Binding the selected item to a constant for preview
//            options: ["Test 1", "Test 2", "Test 3", "Test 4"],
//            onItemSelected: { selected in
//                print("Selected Item: \(selected)") // Placeholder for selection action
//            }
//        )
//        .padding()
//        .background(.red) // Background for the preview to visualize the component
//    }
//}
