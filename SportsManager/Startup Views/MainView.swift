//
//  MainView.swift
//  MainView
//
//  Created by Sam Lally, Brian Nguyen, and Kevin Krupa on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            TeamsList()
                .tabItem {
                    Image(systemName: "sportscourt")
                    Text("Teams")
                }
            PlayersList()
                .tabItem {
                    Image(systemName: "person.3.sequence.fill")
                    Text("Players")
                }
            SearchDatabase()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle")
                    Text("Search")
                }
            ClipsList()
                .tabItem {
                    Image(systemName: "play.rectangle.fill")
                    Text("Clips")
                }
            Settings()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            
        }   // End of TabView
            .font(.headline)
            .imageScale(.medium)
            .font(Font.title.weight(.regular))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
