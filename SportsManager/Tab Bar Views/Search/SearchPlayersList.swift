//
//  SearchPlayersList.swift
//  SearchPlayersList
//
//  Created by Sam Lally.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct SearchPlayersList: View {
    var body: some View {
        List {
            ForEach(playersFound) { aPlayer in
                if(aPlayer.sport == "American Football" || aPlayer.sport == "Basketball" || aPlayer.sport == "Baseball") {
                    NavigationLink(destination: SearchPlayersDetails(player: aPlayer)) {
                        SearchPlayersItem(player: aPlayer)
                    }
                }
            }
        } // End of List
        .navigationBarTitle(Text("Players Found"), displayMode: .inline)
    } // End of body
}

struct SearchPlayersList_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlayersList()
    }
}
