//
//  NetworkingTests.swift
//  PokeAPITests
//
//  Created by Camilo Jimenez on 15/09/21.
//
@testable import PokeAPI
import XCTest

class NetworkingTests: XCTestCase {

    var networking = Networking.shared
    
    func testGetListUrlTestError() throws {
        networking.get(URL(string: "www.error-1.com")!) { (res: [GenerationsModel]?, error: Error?) in
            if let _ = error {
                XCTFail()
            } else {
                XCTAssertTrue(res != nil)
            }
        }
    }
    
    
    func testGetListDecodeTest() throws {
        networking.get(URL(string: Constants.API.RandomPokemonList())!) { (res: [GenerationsModel]?, error: Error?) in
            if let _ = error {
                XCTFail()
            } else {
                XCTAssertTrue(res != nil)
            }
        }
    }
    
    override class func tearDown() {
        super.tearDown()
    }
}
