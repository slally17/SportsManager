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
        List {
            ForEach(playersFound) { player in
                NavigationLink(destination: PlayerStructDetails(player: player)) {
                    PlayerStructItem(player: player)
                }
            }
        }
        .navigationBarTitle(Text("\(team.name ?? "") Roster"), displayMode: .inline)
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
