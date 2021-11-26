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
