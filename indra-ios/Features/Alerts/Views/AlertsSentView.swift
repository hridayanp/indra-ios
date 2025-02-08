//
//  AlertsSentView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 08/02/25.
//

import SwiftUI

struct AlertsSentView: View {
    
    @State private var dateFrom: String = ""
    @State private var dateTo: String = ""
    @State private var alertType = "Alert Type"
    
    let selectOptions = ["Alert Test 1", "Alert Test 2", "Alert Test 3"]
    
    var body: some View {
        BaseView {
            ZStack {
                GlassmorphicBackground()
                    .padding(.horizontal, 16)
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Date From
                    VStack {
                        Text("Date From")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        CustomDatePicker(selectedDate: $dateFrom)
                        Text("Selected From: \(dateFrom)")
                            .foregroundColor(.white)
                    }
                    
                    // Date To
                    VStack {
                        Text("Date To")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                        
                        CustomDatePicker(selectedDate: $dateTo)
                        Text("Selected To: \(dateTo)")
                            .foregroundColor(.white)
                    }
                    
                    // Alert Type Dropdown
                    CustomDropdown(selectedItem: $alertType, options: selectOptions) { selectedAlert in
                        alertType = selectedAlert
                        print("Alert type changed to: \(selectedAlert)")
                    }
                    .padding(.horizontal, 16)
                    
                    // Submit Button
                    CustomButton(
                        title: "Submit",
                        type: .primary,
                        action: {
                            let payload: [String: String] = [
                                "date_from": dateFrom,
                                "date_to": dateTo,
                                "alert_type": alertType
                            ]
                            print("Payload: \(payload)")
                        }
                    )
                    .padding(.horizontal, 16)
                }
                .padding(16)
            }
            .fixedSize(horizontal: false, vertical: true)
            .onAppear {
                let currentDate = getCurrentDate()
                dateFrom = currentDate
                dateTo = currentDate
            }
        }
    }
    
    /// Function to get current date in `YYYY-DD-MM` format
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-dd-MM"
        return formatter.string(from: Date())
    }
}

#Preview {
    AlertsSentView()
}
