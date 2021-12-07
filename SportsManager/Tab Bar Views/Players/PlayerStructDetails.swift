//
//  PlayerStructDetails.swift
//  PlayerStructDetails
//
//  Created by Kevin Krupa on 12/7/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct PlayerStructDetails: View {
    
    let player: PlayerStruct
    
    var body: some View {
        Form {
            Section (header: Text("Player Name")) {
                Text(player.name)
            }
            Section (header: Text("Player Photo")) {
                getImageFromUrl(url: player.photoUrl, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            }
            Section (header: Text("Player Position")) {
                Text(player.position)
            }
            Section (header: Text("Player Build")) {
                Text("Height: \(player.height) Weight: \(player.weight)")
            }
            Section (header: Text("Player Sport")) {
                Text(player.sport)
            }
            Section (header: Text("Player Information")) {
                Text(player.about)
            }
            
        }
    }
}
