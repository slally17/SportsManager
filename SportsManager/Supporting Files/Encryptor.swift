//
//  Encryptor.swift
//  Encryptor
//
//  Created by Brian Nguyen.
//  Copyright © 2021 CS3714 Team 7. All rights reserved.
//

import Foundation

func encrypt(message: String, shift: Int) -> String {

    func shiftLetter(ucs: UnicodeScalar) -> UnicodeScalar {
        //set range to be between uppercase A and lowercase z
        let firstLetter = Int(UnicodeScalar("A").value)
        let lastLetter = Int(UnicodeScalar("z").value)
        let letterCount = lastLetter - firstLetter + 1

        let value = Int(ucs.value)
        switch value {
        case firstLetter...lastLetter:
            // Offset relative to first letter:
            var offset = value - firstLetter
            // Apply shift amount (can be positive or negative):
            offset += shift
            // Transform back to the range firstLetter...lastLetter:
            offset = (offset % letterCount + letterCount) % letterCount
            // Return corresponding character:
            return UnicodeScalar(firstLetter + offset)!
        default:
            // Not in the range, leave unchanged:
            return ucs
        }
    }
    //return the given string that has been shifted
    return String(String.UnicodeScalarView(message.unicodeScalars.map(shiftLetter)))
}
