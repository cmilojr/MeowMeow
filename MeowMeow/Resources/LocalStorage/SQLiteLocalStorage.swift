//
//  Storage.swift
//  MeowMeow
//
//  Created by Camilo Jimenez on 6/08/21.
//

import Foundation
import SQLite

protocol LocalStorageProtocol {
    func putPost(didLike: Bool, catData: BreedsModel, date: Date) throws
    func deleteAllData() throws
    func getCats() throws -> [DataModel]
}

struct SQLiteLocalStorage: LocalStorageProtocol {
    private var database: Connection!
    private let catInteractionsTable = Table("CatInteractions")
    private let catInfo = Expression<Data>("catInfo")
    private let status = Expression<Bool>("status")
    private let date = Expression<Date>("date")
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
            let createTable = self.catInteractionsTable.create { table in
                table.column(self.catInfo)
                table.column(self.status)
                table.column(self.date)
                table.column(self.id, primaryKey: true)
            }
            try self.database.run(createTable)
        } catch {
            throw StorageError.errorCreatingTable
        }
    }
    
    func putPost(didLike: Bool, catData: BreedsModel, date: Date) throws {
        do {
            let catInfo = try JSONEncoder().encode(catData)
            let inserPost = self.catInteractionsTable.insert(
                self.id <- catData.id,
                self.catInfo <- catInfo,
                self.status <- didLike,
                self.date <- date
            )
            try self.database.run(inserPost)
        } catch {
            throw error
        }
    }
    
    func getCats() throws -> [DataModel] {
        do {
            var catsArray: [DataModel] = []
            let cats = try self.database.prepare(self.catInteractionsTable)
            for p in cats {
                let catInfo = try JSONDecoder().decode(BreedsModel.self, from: p[self.catInfo])
                let cat = DataModel(catInfo: catInfo, like: p[self.status], dateInteraction: p[self.date])
                catsArray.append(cat)
            }
            return catsArray
        } catch {
            throw error
        }
    }
    
    func deleteAllData() throws {
        do {
            let drop = self.catInteractionsTable.drop(ifExists: true)
            try self.database.run(drop)
        } catch {
            throw StorageError.errorDropingTable
        }
    }
}

