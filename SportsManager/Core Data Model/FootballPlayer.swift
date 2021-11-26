//
//  FootballPlayer.swift
//  FootballPlayer
//
//  Created by Sam Lally on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import Foundation
import CoreData

// ❎ CoreData Football Player entity public class
public class FootballPlayer: NSManagedObject, Identifiable {

    @NSManaged public var name: String?
    @NSManaged public var age: NSNumber?
    @NSManaged public var height: NSNumber?
    @NSManaged public var weight: NSNumber?
    @NSManaged public var team: Team?
    @NSManaged public var photo: Photo?
}
