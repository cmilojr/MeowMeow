//
//  Storage.swift
//  iBuy
//
//  Created by Camilo Jimenez on 6/08/21.
//

import Foundation
import SQLite

struct Storage {
    private var database: Connection!
    private let favoritePokemonsTable = Table("FavoritePokemons")
    private let name = Expression<String>("name")
    private let url = Expression<String>("url")
    
    static let shared = Storage()
    
    private init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("FavoritePokemons").appendingPathExtension("sqlite3")
            let db = try Connection(fileUrl.path)
            self.database = db
        } catch {
            print(error)
        }
        
        do {
            try self.createTable()
        } catch {
            print(error)
        }
    }
    
    private func createTable() throws {
        do {
            let createTable = self.favoritePokemonsTable.create { table in
                table.column(self.name, primaryKey: true)
                table.column(self.url)
            }
            try self.database.run(createTable)
        } catch {
            throw error
        }
    }
    
    func putPokemon(pokemonDescription: Description) throws {
        do {
            let inserPokemon = self.favoritePokemonsTable.insert(self.name <- pokemonDescription.name, self.url <- pokemonDescription.url)
            try self.database.run(inserPokemon)
            print("Pokemon guardado")
        } catch {
            throw error
        }
    }
    
    func deletePokemon(name: String) throws {
        do {
            let pokemons = self.favoritePokemonsTable.where(self.name == name)
            try database.run(pokemons.delete())
        } catch {
            throw error
        }
    }
    
    
    func getPokemons() throws -> [Description] {
        do {
            var favoritePokemonList: [Description] = []
            let pokemons = try self.database.prepare(self.favoritePokemonsTable)
            for p in pokemons {
                favoritePokemonList.append(Description(name: p[self.name], url: p[self.url]))
            }
            return favoritePokemonList
        } catch {
            throw error
        }
    }
    
    func checkPokemon(name: String) throws -> Bool {
        do {
            let pokemons = self.favoritePokemonsTable.where(self.name == name)
            for _ in try database.prepare(pokemons) {
                return true
            }
            return false
        } catch {
            throw error
        }
    }
}

