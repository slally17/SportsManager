//
//  Clip.swift
//  Clip
//
//  Created by Sam Lally.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import Foundation
import CoreData

// ❎ CoreData Clip entity public class
public class Clip: NSManagedObject, Identifiable {
    @NSManaged public var name: String?
    @NSManaged public var youtubeID: String?
}

extension Clip {
    static func allClipsFetchRequest() -> NSFetchRequest<Clip> {
        let fetchRequest = NSFetchRequest<Clip>(entityName: "Clip")
        
        // List the fetched clips in alphabetical order with respect to clip name.
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        return fetchRequest
    }
}
