//
//  PlayerStructItem.swift
//  PlayerStructItem
//
//  Created by Kevin Krupa on 12/7/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct PlayerStructItem: View {
    
    let player: PlayerStruct
    
    var body: some View {
        HStack {
            getImageFromUrl(url: player.photoUrl, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            
            VStack(alignment: .leading) {
                Text(player.name)
                Text("Height: \(player.height) \nWeight: \(player.weight)")
            }
            .font(.system(size: 14))
        }
    }
}
