//
//  TeamItem.swift
//  TeamItem
//
//  Created by Sam Lally on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct TeamItem: View {
    
    let team: Team
    @FetchRequest(fetchRequest: Team.allTeamsFetchRequest()) var allTeamData: FetchedResults<Team>
    
    var body: some View {
        HStack {
            getImageFromBinaryData(binaryData: team.photo!.photoData!, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            
            VStack(alignment: .leading) {
                Text(team.name ?? "")
                Text(team.league ?? "")
                Text(team.sport ?? "")
            }
            .font(.system(size: 14))
        }
    }
}
