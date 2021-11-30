//
//  TeamsList.swift
//  TeamsList
//
//  Created by Sam Lally on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct TeamsList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: Team.allTeamsFetchRequest()) var allTeamData: FetchedResults<Team>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(allTeamData) { team in
                    NavigationLink(destination: TeamDetails(team: team)) {
                        TeamItem(team: team)
                    }
                }
                .onDelete(perform: delete)
                
            }
            .navigationBarTitle(Text("My Teams"), displayMode: .inline)
            .navigationBarItems(leading: EditButton())
            
        }
            .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func delete(at offsets: IndexSet) {
        
        let teamToDelete = allTeamData[offsets.first!]
        
        managedObjectContext.delete(teamToDelete)

        do {
          try managedObjectContext.save()
        } catch {
          print("Unable to delete selected team!")
        }
    }
}
