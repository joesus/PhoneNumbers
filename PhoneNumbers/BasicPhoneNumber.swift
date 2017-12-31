//
//  BasicPhoneNumber.swift
//  aetnaboost
//
//  Created by joesus on 12/29/17.
//  Copyright © 2017 aetnaboost. All rights reserved.
//

import Foundation

struct BasicPhoneNumber: RawRepresentable {

    let rawValue: String

    init?(rawValue: String) {
        guard rawValue.isValidTelephoneNumber else {
            return nil
        }

        self.rawValue = rawValue
    }
}

private extension String {

    var isValidTelephoneNumber: Bool {
        guard !isEmpty,
            let phoneNumber = detectedPhoneNumber
            else {
                return false
        }

        return phoneNumber.range.length == count
    }

    static let PhoneNumberDetector = try? NSDataDetector(
        types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue
    )

    var detectedPhoneNumber: NSTextCheckingResult? {
        guard let detector = String.PhoneNumberDetector,
            let firstMatch = detector.firstMatch(
                in: self,
                options: [],
                range: NSRange(location: 0, length: count)
            )
            else {
                return nil
        }

        return firstMatch
    }
}

