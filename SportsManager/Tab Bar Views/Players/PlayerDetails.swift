//
//  PlayerDetails.swift
//  PlayerDetails
//
//  Created by Sam Lally on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct PlayerDetails: View {
    
    var player: Player
    
    var body: some View {
        Form {
            Section (header: Text("Player Name")) {
                Text(player.name ?? "")
            }
            Section (header: Text("Player Photo")) {
                getImageFromBinaryData(binaryData: player.photo!.photoData!, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            }
            if let tempTeam = player.team as? Team {
                Section (header: Text("Player Team")) {
                    Text(tempTeam.name ?? "")
                }
            }
            Section (header: Text("Player Position")) {
                Text(player.position ?? "")
            }
            Section (header: Text("Jersey Number")) {
                Text("\(player.favorite ?? 0)")
            }
            Section (header: Text("Player Build")) {
                Text("Height: \(player.height ?? "") Weight: \(player.weight ?? "")")
            }
            Section (header: Text("Player Sport")) {
                Text(player.sport ?? "")
            }
            Section (header: Text("Player Information")) {
                Text(player.about ?? "")
            }
            
        }
    }
}
