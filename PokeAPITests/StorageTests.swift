//
//  StorageTests.swift
//  PokeAPITests
//
//  Created by Camilo Jimenez on 14/09/21.
//
@testable import PokeAPI
import XCTest

class StorageTests: XCTestCase {
    let storage = Storage.shared
    
    func testGetPokemonsTest() throws {
        do {
            let res = try storage.getPokemons()
            XCTAssert(res.count > 0)
        } catch {
            XCTFail()
        }
    }
    
    func testCheckPokemonTest() throws {
        do {
            let res = try storage.checkPokemon(name: "papita")
            XCTAssertFalse(res)
        } catch {
            XCTFail()
        }
    }
    
    func testPutPokemonTest() throws {
        let pokemon = Description(name: "Pikachuu", url: "www.pikachu.com")
        XCTAssertNoThrow(try storage.putPokemon(pokemonDescription: pokemon))
    }
    
    func testDeletePokemonPokemonTest() throws {
        let pokemon = Description(name: "Pikachuu", url: "www.pikachu.com")
        XCTAssertNoThrow(try storage.deletePokemon(name: pokemon.name))
    }
}
