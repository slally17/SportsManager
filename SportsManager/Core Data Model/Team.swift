//
//  Team.swift
//  Team
//
//  Created by Sam Lally on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import Foundation
import CoreData

// ❎ CoreData Album entity public class
public class Team: NSManagedObject, Identifiable {

    @NSManaged public var name: String?
    @NSManaged public var sport: String?
    @NSManaged public var baseballPlayers: NSSet?
    @NSManaged public var basketballPlayers: NSSet?
    @NSManaged public var footballPlayers: NSSet?
    @NSManaged public var photo: Photo?
}

extension Team {

    static func allTeamsFetchRequest() -> NSFetchRequest<Team> {
        /*
         Create a fetchRequest to fetch Team entities from the database.
         Since the fetchRequest's 'predicate' property is not set to filter,
         all of the Team entities will be fetched.
         */
        let fetchRequest = NSFetchRequest<Team>(entityName: "Team")
        /*
         List the fetched teams in alphabetical order with respect to name
         */
        fetchRequest.sortDescriptors = [
            // Primary sort key: name
            NSSortDescriptor(key: "name", ascending: false)
        ]
        
        return fetchRequest
    }
    
    /*
     ❎ CoreData @FetchRequest in TeamsList.swift invokes this class method
        to fetch filtered Team entities from the database for the given search query.
        The 'static' keyword designates the func as a class method invoked by using the
        class name as Team.filteredTeamsFetchRequest() in any .swift file in your project.
     */
    static func filteredTeamsFetchRequest(searchCategory: String, searchQuery: String) -> NSFetchRequest<Team> {
        /*
         Create a fetchRequest to fetch Team entities from the database.
         Since the fetchRequest's 'predicate' property is set to a NSPredicate condition,
         only those Team entities satisfying the condition will be fetched.
         */
        let fetchRequest = NSFetchRequest<Team>(entityName: "Team")
        
        /*
         List the fetched teams in alphabetical order with respect to name
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
        case "Team Name":
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
