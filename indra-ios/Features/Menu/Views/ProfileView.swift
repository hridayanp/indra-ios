import SwiftUI

struct ProfileView: View {
    
    @State private var email: String = "hridayan@misteo.co"
    @State private var firstName: String = "Test"
    @State private var lastName: String = "Dev"
    @State private var isEditing: Bool = false  // State to track edit mode
    @State private var navigateToChangePassword = false  // State to manage navigation to change password screen
    
    @Binding var isInDetailView: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "#0B1D29")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 20) {
//                    Text("Profile")
//                        .font(.system(size: 28, weight: .bold, design: .default))
//                        .foregroundColor(.white)
//                        .padding(.bottom, 10)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("First Name")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(.white)
                        
                        CustomTextField(placeholder: "Enter First Name", text: $firstName, keyboardType: .default, isEditable: isEditing)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Last Name")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(.white)
                        
                        CustomTextField(placeholder: "Enter Last Name", text: $lastName, keyboardType: .default, isEditable: isEditing)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Email")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(.white)
                        
                        CustomTextField(placeholder: "Enter Email", text: $email, keyboardType: .emailAddress, isEditable: isEditing)
                    }
                    
                    Spacer()
                    
                    // Buttons
                    HStack(spacing: 20) {
                        if isEditing {
                            CustomButton(
                                title: "Cancel",
                                type: .secondary,
                                action: {
                                    isEditing = false // Cancel editing
                                },
                                isDisabled: false,
                                isLoading: false
                            )
                            
                            CustomButton(
                                title: "Update",
                                type: .primary,
                                action: {
                                    print("Updated Values: First Name: \(firstName), Last Name: \(lastName), Email: \(email)")
                                    isEditing = false // Save and exit editing
                                },
                                isDisabled: firstName.isEmpty || lastName.isEmpty || email.isEmpty,
                                isLoading: false
                            )
                        } else {
                            CustomButton(
                                title: "Edit",
                                type: .primary,
                                action: {
                                    isEditing = true // Enable editing
                                },
                                isDisabled: false,
                                isLoading: false
                            )
                            
                            // Corrected NavigationLink
                            NavigationLink(
                                value: navigateToChangePassword // Binding state to trigger navigation
                            ) {
                                CustomButton(
                                    title: "Change Password",
                                    type: .secondary,
                                    action: {
                                        navigateToChangePassword = true // Trigger navigation
                                    },
                                    isDisabled: false,
                                    isLoading: false
                                )
                            }
                        }
                    }
                    .padding(.top, 20) // Adding some space at the top of the buttons
                }
                .padding()
            }
            .navigationDestination(isPresented: $navigateToChangePassword) {
                ChangePasswordView(isInDetailView: $isInDetailView) // Destination view to navigate to
            }
        }
    }
}

#Preview {
    ProfileView(isInDetailView: .constant(false))
}
