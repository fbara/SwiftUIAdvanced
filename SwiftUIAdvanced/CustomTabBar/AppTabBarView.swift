//
//  AppTabBarView.swift
//  SwiftUIAdvanced
//
//  Created by Frank Bara on 11/5/21.
//

import SwiftUI

// Generics
// ViewBuilder
// PreferenceKey
// MatchedGeometryEffect

struct AppTabBarView: View {
    
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.red
                .tabBarItem(tab: .home, selection: $tabSelection)
            
            Color.blue
                .tabBarItem(tab: .favorites, selection: $tabSelection)
            
            Color.green
                .tabBarItem(tab: .profile, selection: $tabSelection)
        }
    }
}

struct AppTabBarView_Previews: PreviewProvider {
         
    static var previews: some View {
        AppTabBarView()
    }
}

extension AppTabBarView {
    
    private var defaultTabView: some View {
        
        TabView(selection: $selection) {
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            Color.blue
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            
            Color.orange
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        
    }
}
