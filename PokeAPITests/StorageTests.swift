//
//  StorageTests.swift
//  iBuyTests
//
//  Created by Camilo Jimenez on 17/08/21.
//
@testable import iBuy
import XCTest

class StorageTests: XCTestCase {
    var storage = Storage.shared
    
    func testSetLocalCountryError() throws {
        let country = CountryModel(default_currency_id: "1234", id: "1234", name: "Colombia")
        XCTAssertNoThrow(try storage.setLocalCountry(country))
    }
    
    func testGetLocalCountryError() throws {
        XCTAssertNoThrow(try storage.getLocalCountry())
    }
}
