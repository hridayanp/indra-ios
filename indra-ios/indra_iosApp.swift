//
//  indra_iosApp.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import SwiftUI

@main
struct indra_iosApp: App {
    // Set the global orientation to portrait
    init() {
        // Lock orientation to portrait at app launch
        AppUtility.lockOrientation(.portrait)
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .onAppear {
                    // Ensure orientation remains locked when the view appears
                    AppUtility.lockOrientation(.portrait)
                }
                .onDisappear {
                    // Unlock orientation when leaving this view
                    AppUtility.unlockOrientation()
                }
        }
    }
}

struct AppUtility {
    // Lock the app to a specific orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    // Unlock orientation restrictions
    static func unlockOrientation() {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = .all
        }
    }
}
