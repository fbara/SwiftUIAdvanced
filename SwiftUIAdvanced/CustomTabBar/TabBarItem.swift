//
//  TabBarItem.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/5/21.
//

import Foundation
import SwiftUI

//struct TabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabBarItem: Hashable {
    case home, favorites, profile
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .favorites: return "heart"
        case .profile: return "person"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "home"
        case .favorites: return "favorites"
        case .profile: return "profile"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return Color.red
        case .favorites: return Color.blue
        case .profile: return Color.green
        }
    }
}
