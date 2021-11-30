//
//  SearchPlayersDetails.swift
//  SearchPlayersDetails
//
//  Created by Sam Lally on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct SearchPlayersDetails: View {
    
    let player: PlayerStruct
    
    var body: some View {
        Form {
            Section(header: Text("Player Name")) {
                Text(player.name)
            }
            
            Section(header: Text("Player Photo")) {
                getImageFromUrl(url: player.photoUrl, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            }
            
            Section(header: Text("Player Sport Position")) {
                Text("\(player.sport) \(player.position)")
            }
            
            Section(header: Text("Player Height")) {
                if(player.height.isEmpty) {
                    Text("Unknown")
                }
                else {
                    Text(player.height)
                }
            }
            
            Section(header: Text("Player Weight")) {
                if(player.weight.isEmpty) {
                    Text("Unknown")
                }
                else {
                    Text(player.weight)
                }
            }
            
            Section(header: Text("Player About")) {
                Text(player.about)
            }
        } // End of Form
        .navigationBarTitle(Text("\(player.name) Details"), displayMode: .inline)
        .font(.system(size: 14))
    } // End of body
}
