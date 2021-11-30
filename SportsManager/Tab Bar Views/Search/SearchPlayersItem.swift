//
//  SearchPlayersItem.swift
//  SearchPlayersItem
//
//  Created by Sam Lally on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct SearchPlayersItem: View {
    
    let player: PlayerStruct
    
    var body: some View {
        HStack {
            getImageFromUrl(url: player.photoUrl, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            
            VStack(alignment: .leading) {
                Text(player.name)
                Text(player.sport)
            }
            .font(.system(size: 14))
        } // End of HStack
    } // End of body
}
