//
//  TeamRoster.swift
//  TeamRoster
//
//  Created by Sam Lally, Brian Nguyen, and Kevin Krupa on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct TeamRoster: View {
    
    var team: Team
    
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 1.0, blue: 240/255).edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(systemName: "exclamationmark.triangle")
                    .imageScale(.large)
                    .font(Font.title.weight(.medium))
                    .foregroundColor(.red)
                    .padding()
                Text("This Page is Still Under Work!\n\nNeed to complete populating the roster array!")
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
    
    /**
     List {
         ForEach(Array(team.Players as? Set<Player> ?? []), id: \.self) { player in
             NavigationLink(destination: PlayerDetails(player: player)) {
                 PlayerItem(player: player)
             }
         }
     }
     .navigationBarTitle(Text("\(team.name ?? "") Roster"), displayMode: .inline)
     */
    
}
