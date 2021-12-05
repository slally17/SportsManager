//
//  TeamData.swift
//  TeamData
//
//  Created by Sam Lally, Brian Nguyen, and Kevin Krupa on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import SwiftUI
import CoreData

// Array of Team structs for use only in this file
fileprivate var teamStructList = [TeamStruct]()

/*
 **************************
 MARK: Create Team Database
 **************************
 */
public func createTeamsDatabase() {

    teamStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: "TeamData.json", fileLocation: "Main Bundle")
    
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
    let fetchRequest = NSFetchRequest<Team>(entityName: "Team")
    fetchRequest.sortDescriptors = [
        // Primary sort key: name
        NSSortDescriptor(key: "name", ascending: true)
    ]
    
    var listOfAllTeamEntitiesInDatabase = [Team]()
    
    do {
        //-----------------------------
        // ❎ Execute the Fetch Request
        //-----------------------------
        listOfAllTeamEntitiesInDatabase = try managedObjectContext.fetch(fetchRequest)
    } catch {
        print("Populate Database Failed!")
        return
    }
    
    if listOfAllTeamEntitiesInDatabase.count > 0 {
        // Database has already been populated
        print("Database has already been populated!")
        return
    }
    
    print("Database will be populated!")
    
    for aTeam in teamStructList {
        /*
         =====================================================
         Create an instance of the Team Entity and dress it up
         =====================================================
        */
        
        // ❎ Create an instance of the Team entity in CoreData managedObjectContext
        let teamEntity = Team(context: managedObjectContext)
        
        // ❎ Dress it up by specifying its attributes
        teamEntity.name = aTeam.name
        teamEntity.sport = aTeam.sport
        teamEntity.league = aTeam.league
        teamEntity.about = aTeam.about

        /*
         ======================================================
         Create an instance of the Photo Entity and dress it up
         ======================================================
         */
        
        // ❎ Create an instance of the Photo Entity in CoreData managedObjectContext
        let photoEntity = Photo(context: managedObjectContext)
        
        // Obtain the photo image from Assets.xcassets as UIImage
        let photoUIImage = getUIImageFromUrl(url: aTeam.photoUrl, defaultFilename: "ImageUnavailable")
        
        // Convert photoUIImage to data of type Data (Binary Data) in JPEG format with 100% quality
        let photoData = photoUIImage.jpegData(compressionQuality: 1.0)
        
        // Assign photoData to Core Data entity attribute of type Data (Binary Data)
        photoEntity.photoData = photoData!
        
        /*
         ==============================
         Establish Entity Relationships
         ==============================
        */
        
        // ❎ Establish One-to-One relationship between Team and Photo
        teamEntity.photo = photoEntity      // A team can have only one photo
        photoEntity.team = teamEntity      // A photo can belong to only one team
        
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
