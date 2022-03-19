//
//  Storage.swift
//  iBuy
//
//  Created by Camilo Jimenez on 6/08/21.
//

import Foundation
import SQLite

protocol LocalStorageProtocol {
    func putPost(_ postData: BreedsModel) throws
    func deletePost(_ postData: BreedsModel) throws
    func deleteAllData() throws
}

struct SQLiteLocalStorage: LocalStorageProtocol {
    private var database: Connection!
    private let favoritePostTable = Table("FavoritePosts")
    private let name = Expression<String>("name")
    private let temperament = Expression<String>("temperament")
    private let origin = Expression<String>("origin")
    private let description = Expression<String>("description")
    private let life_span = Expression<String>("life_span")
    private let image = Expression<Data>("image")
    private let weight = Expression<Data>("weight")
    private let id = Expression<String>("id")
    
    fileprivate mutating func conectToDatabase() throws {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("LocalStorageContacts").appendingPathExtension("sqlite3")
            let db = try Connection(fileUrl.path)
            self.database = db
        } catch {
            throw StorageError.errorConnection
        }
    }
    
    init() {
        try? conectToDatabase()
        try? createTable()
    }
    
    private func createTable() throws {
        do {
            let createTable = self.favoritePostTable.create { table in
                table.column(self.name)
                table.column(self.description)
                table.column(self.origin)
                table.column(self.temperament)
                table.column(self.weight)
                table.column(self.image)
                table.column(self.id)
                table.column(self.life_span)
                table.primaryKey(self.id)
            }
            try self.database.run(createTable)
        } catch {
            throw StorageError.errorCreatingTable
        }
    }
    
    func putPost(_ postData: BreedsModel) throws {
        do {
            let weightData = try JSONEncoder().encode(postData.weight)
            let imageData = try JSONEncoder().encode(postData.image)
            let inserPost = self.favoritePostTable.insert(
                self.id <- postData.id,
                self.weight <- weightData,
                self.image <- imageData,
                self.name <- postData.name,
                self.temperament <- postData.temperament,
                self.origin <- postData.origin,
                self.description <- description,
                self.life_span <- life_span
            )
            try self.database.run(inserPost)
        } catch {
            throw error
        }
    }
    
    func deletePost(_ postData: BreedsModel) throws {
        do {
            let post = self.favoritePostTable.where(
                self.id == postData.id
            )
            try database.run(post.delete())
        } catch {
            throw error
        }
    }
    
    func deleteAllData() throws {
        do {
            let drop = self.favoritePostTable.drop(ifExists: true)
            try self.database.run(drop)
        } catch {
            throw StorageError.errorDropingTable
        }
    }
}

