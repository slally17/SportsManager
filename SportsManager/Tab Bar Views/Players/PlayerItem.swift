//
//  PlayerItem.swift
//  PlayerItem
//
//  Created by Sam Lally on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct PlayerItem: View {
    let player: Player
    @FetchRequest(fetchRequest: Player.allPlayersFetchRequest()) var allPlayerData: FetchedResults<Player>
    
    var body: some View {
        HStack {
            getImageFromBinaryData(binaryData: player.photo!.photoData!, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            
            VStack(alignment: .leading) {
                Text(player.name ?? "")
                if let tempTeam = player.team as? Team {
                    Text(tempTeam.name ?? "")
                }
                Text("Height: \(player.height ?? "") Weight: \(player.weight ?? "")")
            }
            .font(.system(size: 14))
        }
    }
}
