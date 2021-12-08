//
//  SearchTeamsItem.swift
//  SearchTeamsItem
//
//  Created by Sam Lally.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct SearchTeamsItem: View {
    
    let team: TeamStruct
    
    var body: some View { 
        HStack {
            getImageFromUrl(url: team.photoUrl, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            
            VStack(alignment: .leading) {
                Text(team.name)
                Text(team.sport)
            }
            .font(.system(size: 14))
        } // End of HStack
    } // End of body
}
