//
//  TeamStruct.swift
//  TeamStruct
//
//  Created by Sam Lally, Brian Nguyen, and Kevin Krupa on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import Foundation

struct TeamStruct: Decodable, Identifiable {
    var id: UUID
    var name: String
    var sport: String
    var league: String
    var about: String
    var photoUrl: String
}
