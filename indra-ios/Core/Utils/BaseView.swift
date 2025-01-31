//
//  BaseView.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import SwiftUI

struct BaseView<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color(hex: "#0B1D29") // Apply global background color
                .edgesIgnoringSafeArea(.all)
            
            content // The actual screen content
        }
    }
}

