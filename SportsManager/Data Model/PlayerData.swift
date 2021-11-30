//
//  PlayerData.swift
//  PlayerData
//
//  Created by Sam Lally on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI
import CoreData

// Array of Player structs for use only in this file
fileprivate var playerStructList = [PlayerStruct]()

/*
 ****************************
 MARK: Create Player Database
 ****************************
 */
public func createPlayersDatabase() {

    playerStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: "PlayerData.json", fileLocation: "Main Bundle")
    
    populateDatabase()
}

/*
*******************************************
MARK: Populate Database If Not Already Done
*******************************************
*/
private func populateDatabase() {
    // ❎ Get object reference of CoreData managedObjectContext from the persistent container
    let managedObjectContext = PersistenceController.shared.persistentContainer.viewContext
    
    //----------------------------
    // ❎ Define the Fetch Request
    //----------------------------
    let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
    fetchRequest.sortDescriptors = [
        // Primary sort key: name
        NSSortDescriptor(key: "name", ascending: true)
    ]
    
    var listOfAllPlayerEntitiesInDatabase = [Player]()
    
    do {
        //-----------------------------
        // ❎ Execute the Fetch Request
        //-----------------------------
        listOfAllPlayerEntitiesInDatabase = try managedObjectContext.fetch(fetchRequest)
    } catch {
        print("Populate Database Failed!")
        return
    }
    
    if listOfAllPlayerEntitiesInDatabase.count > 0 {
        // Database has already been populated
        print("Database has already been populated!")
        return
    }
    
    print("Database will be populated!")
    
    for aPlayer in playerStructList {
        /*
         =======================================================
         Create an instance of the Player Entity and dress it up
         =======================================================
        */
        
        // ❎ Create an instance of the Team entity in CoreData managedObjectContext
        let playerEntity = Player(context: managedObjectContext)
        
        // ❎ Dress it up by specifying its attributes
        playerEntity.name = aPlayer.name
        playerEntity.sport = aPlayer.sport
        playerEntity.position = aPlayer.position
        playerEntity.height = aPlayer.height
        playerEntity.weight = aPlayer.weight
        playerEntity.about = aPlayer.about

        /*
         ======================================================
         Create an instance of the Photo Entity and dress it up
         ======================================================
         */
        
        // ❎ Create an instance of the Photo Entity in CoreData managedObjectContext
        let photoEntity = Photo(context: managedObjectContext)
        
        // Obtain the album cover photo image from Assets.xcassets as UIImage
        let photoUIImage = getUIImageFromUrl(url: aPlayer.photoUrl, defaultFilename: "ImageUnavailable")
        
        // Convert photoUIImage to data of type Data (Binary Data) in JPEG format with 100% quality
        let photoData = photoUIImage.jpegData(compressionQuality: 1.0)
        
        // Assign photoData to Core Data entity attribute of type Data (Binary Data)
        photoEntity.photoData = photoData!
        
        /*
         ==============================
         Establish Entity Relationships
         ==============================
        */
        
        // ❎ Establish One-to-One relationship between Player and Photo
        playerEntity.photo = photoEntity      // A player can have only one photo
        photoEntity.player = playerEntity      // A photo can belong to only one player
        
        /*
         ==================================
         Save Changes to Core Data Database
         ==================================
        */
        
        // ❎ CoreData Save operation
        do {
            try managedObjectContext.save()
        } catch {
            return
        }
    }
}
