//
//  GlassmorphicBackground.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 03/02/25.
//

import SwiftUI

// MARK: - Glassmorphic Background
struct GlassmorphicBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.clear) // Fully transparent background
            .background(
                BlurView(style: .light) // Subtle blur effect for frosted glass look
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1) // Softer border for visual separation
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
