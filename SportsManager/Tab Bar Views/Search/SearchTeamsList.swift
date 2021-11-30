//
//  SearchTeamsList.swift
//  SearchTeamsList
//
//  Created by Sam Lally on 11/30/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct SearchTeamsList: View {
    var body: some View {
        List {
            ForEach(teamsFound) { aTeam in
                if(aTeam.sport == "American Football" || aTeam.sport == "Basketball" || aTeam.sport == "Baseball") {
                    NavigationLink(destination: SearchTeamsDetails(team: aTeam)) {
                        SearchTeamsItem(team: aTeam)
                    }
                }
            }
        } // End of List
        .navigationBarTitle(Text("Teams Found"), displayMode: .inline)
    } // End of body
}

struct SearchTeamsList_Previews: PreviewProvider {
    static var previews: some View {
        SearchTeamsList()
    }
}
