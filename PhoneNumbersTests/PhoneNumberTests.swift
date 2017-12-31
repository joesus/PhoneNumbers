//
//  PhoneNumberTests.swift
//  PhoneNumbersTests
//
//  Created by Joe Susnick on 12/30/17.
//  Copyright © 2017 Joe Susnick. All rights reserved.
//

import XCTest
@testable import PhoneNumbers

class PhoneNumberTests: XCTestCase {

    var basicNumber: BasicPhoneNumber! = BasicPhoneNumber(rawValue: "1234567890")
    let `extension` = PhoneNumberExtension(rawValue: "123")!

    func testWithoutExtension() {
        let phoneNumber = PhoneNumber(basic: basicNumber)

        XCTAssertEqual(phoneNumber.basicNumber.rawValue, basicNumber.rawValue,
                       "Should be able to create a phone number with only a basic number")
        XCTAssertNil(phoneNumber.extension,
                     "Should be able to create a phone number with only a basic number")
    }

    func testWithExtension() {
        let phoneNumber = PhoneNumber(basic: basicNumber, extension: `extension`)

        XCTAssertEqual(phoneNumber.basicNumber.rawValue, basicNumber.rawValue,
                       "Should be able to create a phone number with both a basic number and an extension")
        XCTAssertEqual(phoneNumber.extension?.rawValue, `extension`.rawValue,
                     "Should be able to create a phone number with both a basic number and an extension")
    }

    func testFormattingNonAmericanNumberWithoutExtension() {
        basicNumber = BasicPhoneNumber(rawValue: "1234567")
        let phoneNumber = PhoneNumber(basic: basicNumber)

        XCTAssertEqual(phoneNumber.formatted, basicNumber.rawValue,
                       "Non American phone numbers should not have special formatting")
    }

    func testFormattingNonAmericanNumberWithExtension() {
        basicNumber = BasicPhoneNumber(rawValue: "1234567")
        let phoneNumber = PhoneNumber(basic: basicNumber, extension: `extension`)

        XCTAssertEqual(
            phoneNumber.formatted,
            "\(basicNumber.rawValue) Ext: \(`extension`.rawValue)",
            "Non American phone numbers should not have special formatting but should display an extension in the standard way. ex: `Ext 123`"
        )
    }

    func testFormattingAmericanNumbersWithoutExtension() {
        ValidUSTelephoneNumbers.forEach { rawString in
            guard let basic = BasicPhoneNumber(rawValue: rawString) else {
                return XCTFail("Should create a basic phone number from \(rawString)")
            }

            XCTAssertEqual(PhoneNumber(basic: basic).formatted, "(123) 456-7890",
                           "Should format American phone numbers in a common format")
        }
    }

    func testFormattingAmericanNumbersWithExtension() {
        ValidUSTelephoneNumbers.forEach { rawString in
            guard let basic = BasicPhoneNumber(rawValue: rawString) else {
                return XCTFail("Should create a basic phone number from \(rawString)")
            }

            XCTAssertEqual(
                PhoneNumber(basic: basic, extension: `extension`).formatted,
                "(123) 456-7890 Ext: \(`extension`.rawValue)",
                "Should format American phone numbers in a common format"
            )
        }
    }

}
