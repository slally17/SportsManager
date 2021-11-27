//
//  Player.swift
//  Player
//
//  Created by Sam Lally on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import Foundation
import CoreData

// ❎ CoreData Player entity public class
public class Player: NSManagedObject, Identifiable {

    @NSManaged public var name: String?
    @NSManaged public var age: NSNumber?
    @NSManaged public var height: NSNumber?
    @NSManaged public var weight: NSNumber?
    @NSManaged public var sport: String?
    @NSManaged public var team: Team?
    @NSManaged public var photo: Photo?
}

extension Player {

    static func allPlayersFetchRequest() -> NSFetchRequest<Player> {
        /*
         Create a fetchRequest to fetch Player entities from the database.
         Since the fetchRequest's 'predicate' property is not set to filter,
         all of the Player entities will be fetched.
         */
        let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
        /*
         List the fetched players in alphabetical order with respect to name
         */
        fetchRequest.sortDescriptors = [
            // Primary sort key: name
            NSSortDescriptor(key: "name", ascending: false)
        ]
        
        return fetchRequest
    }
    
    /*
     ❎ CoreData @FetchRequest in PlayersList.swift invokes this class method
        to fetch filtered Player entities from the database for the given search query.
        The 'static' keyword designates the func as a class method invoked by using the
        class name as Player.filteredPlayersFetchRequest() in any .swift file in your project.
     */
    static func filteredPlayersFetchRequest(searchCategory: String, searchQuery: String) -> NSFetchRequest<Player> {
        /*
         Create a fetchRequest to fetch Player entities from the database.
         Since the fetchRequest's 'predicate' property is set to a NSPredicate condition,
         only those Player entities satisfying the condition will be fetched.
         */
        let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
        
        /*
         List the fetched players in alphabetical order with respect to name
         */
        fetchRequest.sortDescriptors = [
            // Primary sort key: name
            NSSortDescriptor(key: "name", ascending: false),
        ]
        
        /*
         Created NSPredicate object represents a condition or a compound condition with
         AND/OR logical operators, which is used to filter fetching from the database.
         */
        switch searchCategory {
        case "Player Name":
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] %@", searchQuery)
        case "Trip Rating":
            fetchRequest.predicate = NSPredicate(format: "rating CONTAINS[c] %@", searchQuery)
        case "Trip Title":
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[c] %@", searchQuery)
        case "Trip Start Date":
            fetchRequest.predicate = NSPredicate(format: "startDate CONTAINS[c] %@", searchQuery)
        case "Trip End Date":
            fetchRequest.predicate = NSPredicate(format: "endDate CONTAINS[c] %@", searchQuery)
        case "Trip Notes":
            fetchRequest.predicate = NSPredicate(format: "notes CONTAINS[c] %@", searchQuery)
        case "Compound":
            let components = searchQuery.components(separatedBy: "AND")
            let startDateQuery = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let ratingQuery = components[1].trimmingCharacters(in: .whitespacesAndNewlines)

            fetchRequest.predicate = NSPredicate(format: "startDate CONTAINS[c] %@ AND rating CONTAINS[c] %@", startDateQuery, ratingQuery)
        default:
            print("Search category is out of range")
        }
        
        return fetchRequest
    }
}
