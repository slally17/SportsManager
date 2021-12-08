//
//  PlayerItem.swift
//  PlayerItem
//
//  Created by Kevin Krupa.
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
                Text(player.teamName ?? "")
                Text("Height: \(player.height ?? "") \nWeight: \(player.weight ?? "")")
            }
            .font(.system(size: 14))
        }
    }
}
