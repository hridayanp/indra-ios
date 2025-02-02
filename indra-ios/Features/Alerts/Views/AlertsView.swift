//
//  AlertsView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import SwiftUI

struct AlertsView: View {
    var body: some View {
        BaseView {
            VStack {
                Text("Alerts")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
            .navigationTitle("Alerts")
        }
        
        
        
    }
}

#Preview {
    AlertsView()
}
