//
//  AuthorController.swift
//  MyLibraryApp
//
//  Created by Kemas Deanova on 11/08/25.
//

import Foundation
import SQLite

class AuthorController {
    private let db: Connection
    private let authorsTable = Table("authors")
    private let id = Expression<Int64>("id")
    private let name = Expression<String>("name")
    
    init() {
        guard let connection = DatabaseManager.shared.connection else {
            fatalError("Database connection not available.")
        }
        
        self.db = connection
        createTable()
    }
    
    private func createTable() {
        do {
            try db.run(authorsTable.create(ifNotExists: true){
                table in
                table.column(id, primaryKey: .autoincrement)
                table.column(name)
            })
        }catch{
            print("Error creating author table. Error: \(error)")
        }
    }
    
    func add(name: String)
    {
        do{
            let insert = authorsTable.insert(self.name <- name)
            try db.run(insert)
            print("Author added: \(name)")
        }catch{
            print("Error inserting author. Error: \(error)")
        }
    }
    
    func getAll() -> [Author]
    {
        var authors: [Author] = []
        
        do{
            for row in try db.prepare(authorsTable) {
                authors.append(Author(id: row[id], name: row[name]))
            }
        }catch{
            print("Fetch authors failed. Error: \(error)")
        }
        return authors
    }
    
    func update(id authorId: Int64, newName: String)
    {
        let author = authorsTable.filter(id == authorId)
        
        do{
            try db.run(author.update(name <- newName))
            print("Author updated: \(newName)")
        }catch{
            print("Update author failed. Error: \(error)")
        }
    }
    
    func delete(id authorId: Int64)
    {
        let author = authorsTable.filter(id == authorId)
        do{
            try db.run(author.delete())
            print("Author deleted.")
        }catch{
            print("Failed to delete the author. Error: \(error)")
        }
    }
}
