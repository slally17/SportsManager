//
//  PlayerStruct.swift
//  PlayerStruct
//
//  Created by Sam Lally on 11/24/21.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import Foundation

struct PlayerStruct: Decodable, Identifiable {
    var id: UUID
    var name: String
    var sport: String
    var position: String
    var height: String
    var weight: String
    var about: String
    var photoUrl: String
}
