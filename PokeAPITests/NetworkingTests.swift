//
//  NetworkingTests.swift
//  iBuyTests
//
//  Created by Camilo Jimenez on 17/08/21.
//

@testable import iBuy
import XCTest
class NetworkingTests: XCTestCase {

    var networking = Networking.shared

    func testGetListUrlTestError() throws {
        networking.getList(URL(string: "www.error-1.com")!) { (res: [CountryModel]?, error: Error?) in
            if let _ = error {
                XCTFail()
            } else {
                XCTAssertTrue(res != nil)
            }
        }
    }
    
    func testGetItemsUrlTestError() throws {
        networking.getList(URL(string: "www.error.com")!) { (res: [ProductResponse]?, error: Error?) in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                if let e = error {
                    XCTAssertNil(e)
                } else {
                    XCTAssertNotNil(res)
                }

             }
        }
    }
    
    func testGetListDecodeTestError() throws {
        networking.getList(URL(string: try Constants.API.CategoriesAvailable())!) { (res: [ProductResponse]?, error: Error?) in
            if let _ = error {
                XCTFail()
            } else {
                XCTAssertTrue(res != nil)
            }
        }
    }

    func testGetItemsCategoryNullTestError() throws {
        networking.getItems(URL(string: try Constants.API.ItemInCategoryAvailable(""))!) { (res: ProductsResponse?, error: Error?) in
            if let _ = error {
                XCTFail()
            } else {
                XCTAssertTrue(res != nil)
            }
        }
    }

    func testGetListUrlTest() throws {
        networking.getList(URL(string: try Constants.API.CategoriesAvailable())!) { (res: [CountryModel]?, error: Error?) in
            if let _ = error {
                XCTFail()
            } else {
                XCTAssertTrue(res != nil)
            }

        }
    }
    
    func testGetItemsUrlTest() throws {
        networking.getList(URL(string: try Constants.API.CategoriesAvailable())!) { (res: [ProductResponse]?, error: Error?) in
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
