//
//  BaseballPlayer.swift
//  BaseballPlayer
//
//  Created by Sam Lally on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import Foundation
import CoreData

// ❎ CoreData Baseball Player entity public class
public class BaseballPlayer: NSManagedObject, Identifiable {

    @NSManaged public var name: String?
    @NSManaged public var age: NSNumber?
    @NSManaged public var height: NSNumber?
    @NSManaged public var weight: NSNumber?
    @NSManaged public var team: Team?
    @NSManaged public var photo: Photo?
}
