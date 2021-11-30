//
//  SearchTeamsDetails.swift
//  SearchTeamsDetails
//
//  Created by Sam Lally on 11/30/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct SearchTeamsDetails: View {
    
    let team: TeamStruct
    
    var body: some View {
        Form {
            Section(header: Text("Team Name")) {
                Text(team.name)
            }
            
            Section(header: Text("Team Logo")) {
                getImageFromUrl(url: team.photoUrl, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            }
            
            Section(header: Text("Team League")) {
                Text(team.league)
            }
            
            Section(header: Text("Team About")) {
                Text(team.about)
            }
        } // End of Form
        .navigationBarTitle(Text("\(team.name) Details"), displayMode: .inline)
        .font(.system(size: 14))
    } // End of body
}
