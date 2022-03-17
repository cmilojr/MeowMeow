//
//  Storage.swift
//  iBuy
//
//  Created by Camilo Jimenez on 6/08/21.
//

import Foundation
import SQLite

protocol LocalStorageProtocol {
    func putPost(_ postData: PostModel) throws
    func deletePost(_ postData: PostModel) throws
    func getFavoritePosts() throws -> [PostModel]
    func checkIsFavPost(idPost: Int, userId: Int) throws -> Bool
    func deleteAllData() throws
}

struct SQLiteLocalStorage: LocalStorageProtocol {
    private var database: Connection!
    private let favoritePostTable = Table("FavoritePosts")
    private let title = Expression<String>("title")
    private let userId = Expression<Int>("userId")
    private let body = Expression<String>("body")
    private let id = Expression<Int>("id")
    
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
                table.column(self.userId)
                table.column(self.title)
                table.column(self.body)
                table.column(self.id)
                table.primaryKey(self.id, self.userId)
            }
            try self.database.run(createTable)
        } catch {
            throw StorageError.errorCreatingTable
        }
    }
    
    func putPost(_ postData: PostModel) throws {
        do {
            let inserPost = self.favoritePostTable.insert(
                self.userId <- postData.userId,
                self.title <- postData.title,
                self.body <- postData.body,
                self.id <- postData.id
            )
            try self.database.run(inserPost)
            print(try getFavoritePosts())
        } catch {
            throw error
        }
    }
    
    func deletePost(_ postData: PostModel) throws {
        do {
            let post = self.favoritePostTable.where(
                self.id == postData.id && self.userId == postData.userId
            )
            try database.run(post.delete())
            print(try getFavoritePosts())
        } catch {
            throw error
        }
    }
    
    func getFavoritePosts() throws -> [PostModel] {
        do {
            var favoritePostArray: [PostModel] = []
            let pokemons = try self.database.prepare(self.favoritePostTable)
            for p in pokemons {
                let post = PostModel(userId: p[self.userId], id: p[self.id], body: p[self.body], title: p[self.title])
                favoritePostArray.append(post)
            }
            return favoritePostArray
        } catch {
            throw error
        }
    }
    
    func checkIsFavPost(idPost: Int, userId: Int) throws -> Bool {
        do {
            let post = self.favoritePostTable.where(self.id == idPost && self.userId == userId)
            for _ in try database.prepare(post) {
                return true
            }
            return false
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

