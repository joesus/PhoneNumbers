//
//  PhoneNumberExtension.swift
//  PhoneNumbers
//
//  Created by Joe Susnick on 12/30/17.
//  Copyright © 2017 Joe Susnick. All rights reserved.
//

import Foundation

struct PhoneNumberExtension: RawRepresentable {
    var rawValue: String

    init?(rawValue: String) {
        guard !rawValue.isEmpty else { return nil }

        for character in rawValue {
            guard let scalar = UnicodeScalar(String(character)),
                CharacterSet.decimalDigits.contains(scalar)
                else {
                    return nil
            }
        }

        self.rawValue = rawValue
    }
}
