//
//  MenuView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 01/02/25.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Text("Menu")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }
        .padding()
        .navigationTitle("Menu")
    }
}

#Preview {
    MenuView()
}
