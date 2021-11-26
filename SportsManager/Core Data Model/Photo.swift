//
//  Photo.swift
//  Photo
//
//  Created by Sam Lally on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import Foundation
import CoreData

// ❎ CoreData Photo entity public class
public class Photo: NSManagedObject, Identifiable {

    @NSManaged public var photoData: Data?
    @NSManaged public var team: Team?
}
