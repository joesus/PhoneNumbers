//
//  PhoneNumber.swift
//  PhoneNumbers
//
//  Created by Joe Susnick on 12/30/17.
//  Copyright © 2017 Joe Susnick. All rights reserved.
//

import Foundation

struct PhoneNumber {
    let basicNumber: BasicPhoneNumber
    let `extension`: PhoneNumberExtension?

    init(basic: BasicPhoneNumber, `extension`: PhoneNumberExtension? = nil) {
        basicNumber = basic
        self.extension = `extension`
    }

    var formatted: String {
        let basicFormatted = basicNumberFormattedForUs ?? basicNumber.rawValue

        var extensionFormatted: String? = nil
        if let rawExtension = `extension`?.rawValue {
            extensionFormatted = "Ext: \(rawExtension)"
        }

        return [basicFormatted, extensionFormatted]
            .flatMap { $0 }
            .joined(separator: " ")
    }

    private var basicNumberFormattedForUs: String? {
        guard let digits = usNumberDigits else { return nil }

        let areaCode = digits.prefix(3)
        let local = digits.suffix(7)
        let prefix = local.prefix(3)
        let suffix = local.suffix(4)

        return "(\(areaCode)) \(prefix)-\(suffix)"
    }

    private var usNumberDigits: String? {
        var digits = basicNumber.rawValue.digits
        if digits.count == 11,
            digits.first == "1" {

            digits = String(digits.dropFirst())
        }

        return digits.count == 10 ? String(digits) : nil
    }

}

private extension String {

    var digits: String {
        return filter {
            guard let scalar = UnicodeScalar(String($0)) else { return false }

            return CharacterSet.decimalDigits.contains(scalar)
        }
    }
}
