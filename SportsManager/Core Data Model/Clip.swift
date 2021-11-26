//
//  Clip.swift
//  Clip
//
//  Created by Sam Lally on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import Foundation
import CoreData

// ❎ CoreData Clip entity public class
public class Clip: NSManagedObject, Identifiable {

    @NSManaged public var youtubeID: String?
}
