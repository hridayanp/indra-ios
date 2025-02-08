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

    
    var body: some View {
        BaseView {
            ZStack {
                GlassmorphicBackground()
                    .padding(.horizontal, 16)
                
                VStack(alignment: .leading, spacing: 0) {
                    VStack(spacing: 16) {
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
                        
                    }
                }
                .padding(16)
                
                
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    AlertsSentView()
}
