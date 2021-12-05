//
//  TeamDetails.swift
//  TeamDetails
//
//  Created by Sam Lally, Brian Nguyen, and Kevin Krupa on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct TeamDetails: View {
    
    var team: Team
    
    var body: some View {
        Form {
            Section (header: Text("Team Name")) {
                Text(team.name ?? "")
            }
            Section (header: Text("Team Photo")) {
                getImageFromBinaryData(binaryData: team.photo!.photoData!, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            }
            Section (header: Text("Team League")) {
                Text(team.league ?? "")
            }
            Section (header: Text("Team Roster")) {
                NavigationLink(destination: TeamRoster(team: team)) {
                    HStack {
                        Image(systemName: "person.3")
                        Text("Roster")
                    }
                }
            }
            Section (header: Text("Sport")) {
                Text(team.sport ?? "")
            }
            Section (header: Text("Team Information")) {
                Text(team.about ?? "")
            }
        }
        .navigationBarTitle(Text("Trip Details"), displayMode: .inline)
    }
}
