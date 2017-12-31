//
//  PhoneNumberExtensionTests.swift
//  PhoneNumbersTests
//
//  Created by Joe Susnick on 12/30/17.
//  Copyright © 2017 Joe Susnick. All rights reserved.
//

import XCTest
@testable import PhoneNumbers

class PhoneNumberExtensionTests: XCTestCase {

    func testInvalidExtensions() {
        InvalidPhoneNumberExtensions.forEach { rawString in
            XCTAssertNil(PhoneNumberExtension(rawValue: rawString),
                         "\(rawString) should not create a phone number extension")
        }
    }

    func testValidExtensions() {
        ValidPhoneNumberExtensions.forEach { rawString in
            guard let `extension` = PhoneNumberExtension(rawValue: rawString) else {
                return XCTFail("\(rawString) should create a phone number extension")
            }

            XCTAssertEqual(`extension`.rawValue, rawString,
                           "The raw value \(rawString) should be stored unmodified")
        }
    }

}

private let ValidPhoneNumberExtensions = [
    "0",
    "01",
    "12",
    "123"
]

private let InvalidPhoneNumberExtensions = [
    "",
    " ",
    "a",
    "x1",
    " 1",
    "1 ",
    "Ext: 1",
    "-1",
    "10G"
]
