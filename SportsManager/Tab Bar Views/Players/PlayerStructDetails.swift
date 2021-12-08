//
//  PlayerStructDetails.swift
//  PlayerStructDetails
//
//  Created by Kevin Krupa.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI

struct PlayerStructDetails: View {
    
    // Enable this View to be dismissed to go back when the Save button is tapped
    @Environment(\.presentationMode) var presentationMode
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showChangesSavedAlert = false
    
    let player: PlayerStruct
    
    var body: some View {
        Form {
            Section (header: Text("Player Name")) {
                Text(player.name)
            }
            Section (header: Text("Player Photo")) {
                getImageFromUrl(url: player.photoUrl, defaultFilename: "ImageUnavailable")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            }
            Section (header: Text("Player Team")) {
                Text(player.teamName)
            }
            Section (header: Text("Player Position")) {
                Text(player.position)
            }
            Section (header: Text("Player Build")) {
                Text("Height: \(player.height) Weight: \(player.weight)")
            }
            Section (header: Text("Player Sport")) {
                Text(player.sport)
            }
            Section (header: Text("Player Information")) {
                Text(player.about)
            }
            
        }
        .navigationBarTitle(Text("\(player.name) Details"), displayMode: .inline)
        .alert(isPresented: $showChangesSavedAlert, content: { changesSavedAlert })
        .font(.system(size: 14))
        .navigationBarItems(trailing:
            Button(action: {
                addNewPlayer()
                showChangesSavedAlert = true
            }) {
                Text("Add")
            })
    } // End of body
    
    /*
     -------------------
     MARK: Alert Message
     -------------------
     */
    var changesSavedAlert: Alert {
        return Alert(title: Text("Player Added!"),
          message: Text("Your player have been successfully saved to the database."),
          dismissButton: .default(Text("OK")) {
              presentationMode.wrappedValue.dismiss()
            })
    }
    
    /*
     --------------------
     MARK: Add New Player
     --------------------
     */
    func addNewPlayer() {
        
        // ❎ Create a new Player entity in CoreData managedObjectContext
        let newPlayer = Player(context: managedObjectContext)
        
        // ❎ Dress up the new Player entity
        newPlayer.name = player.name
        newPlayer.teamName = player.teamName
        newPlayer.sport = player.sport
        newPlayer.position = player.position
        newPlayer.height = player.height
        newPlayer.weight = player.weight
        newPlayer.about = player.about
        newPlayer.favorite = true
        
        // ❎ Create an instance of the Photo Entity in CoreData managedObjectContext
        let photoEntity = Photo(context: managedObjectContext)
        // Obtain the  photo image from Assets.xcassets as UIImage
        let photoUIImage = getUIImageFromUrl(url: player.photoUrl, defaultFilename: "ImageUnavailable")
        // Convert photoUIImage to data of type Data (Binary Data) in JPEG format with 100% quality
        let photoData = photoUIImage.jpegData(compressionQuality: 1.0)
        // Assign photoData to Core Data entity attribute of type Data (Binary Data)
        photoEntity.photoData = photoData!
        
        // ❎ Establish One-to-One relationship between Player and Photo
        newPlayer.photo = photoEntity      // A player can have only one photo
        photoEntity.player = newPlayer      // A photo can belong to only one player
        
        // ❎ CoreData Save operation
        do {
            try managedObjectContext.save()
        } catch {
            return
        }
    }
}
