//
//  PlayersList.swift
//  PlayersList
//
//  Created by Kevin Krupa.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct PlayersList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: Player.allPlayersFetchRequest()) var allPlayerData: FetchedResults<Player>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(allPlayerData) { player in
                    NavigationLink(destination: PlayerDetails(player: player)) {
                        PlayerItem(player: player)
                    }
                }
                .onDelete(perform: delete)
                
            }
            .navigationBarTitle(Text("My Players"), displayMode: .inline)
            .navigationBarItems(leading: EditButton())
            
        }
            .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func delete(at offsets: IndexSet) {
        
        let playerToDelete = allPlayerData[offsets.first!]
        
        managedObjectContext.delete(playerToDelete)

        do {
          try managedObjectContext.save()
        } catch {
          print("Unable to delete selected player!")
        }
    }
}
