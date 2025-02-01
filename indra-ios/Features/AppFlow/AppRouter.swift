//
//  AppRouter.swift
//  indra-ios
//
//  Created by Hridayan Phukan on 31/01/25.
//

import Foundation

enum AppRoute {
    case authSelection(AuthTab)
    case forecast
    case mainTabs
}

class AppRouter: ObservableObject {
    @Published var currentRoute: AppRoute? = nil  // Holds current route
    
    func navigate(to route: AppRoute) {
        currentRoute = route
    }
}
