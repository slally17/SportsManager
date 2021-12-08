//
//  TeamStruct.swift
//  TeamStruct
//
//  Created by Sam Lally.
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
