//
//  AppDelegate.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 03/02/25.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    var orientationLock: UIInterfaceOrientationMask = .all
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientationLock
    }
}
