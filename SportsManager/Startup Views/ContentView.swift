//
//  ContentView.swift
//  SportsManager
//
//  Created by Sam Lally on 11/24/21.
//

import SwiftUI

struct ContentView : View {
    
    @State private var userAuthenticated = false
    
    var body: some View {
        
        if userAuthenticated {
            // Foreground View
            MainView()
        } else {
            ZStack {
                // Background View
                LoginView(canLogin: $userAuthenticated)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
