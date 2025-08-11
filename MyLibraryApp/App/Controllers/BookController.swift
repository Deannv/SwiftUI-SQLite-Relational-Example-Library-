//
//  BookController.swift
//  MyLibraryApp
//
//  Created by Kemas Deanova on 11/08/25.
//

import Foundation
import SQLite

class BookController {
    private let db: Connection
    private let booksTable = Table("books")
    private let authorsTable = Table("authors")
    private let id = Expression<Int64>("id")
    private let title = Expression<String>("title")
    private let authorId = Expression<Int64>("authorId")
    
    init() {
        guard let connection = DatabaseManager.shared.connection else {
            fatalError("Database connection not available.")
        }
        
        self.db = connection
        createTable()
    }
    
    private func createTable()
    {
        do{
            try db.run(booksTable.create(ifNotExists: true){
                table in
                table.column(id, primaryKey: .autoincrement)
                table.column(title)
                table.column(authorId)
                table.foreignKey(authorId, references: authorsTable, id, delete: .cascade)
            })
        }catch{
            print("Failed to create books table. Error: \(error)")
        }
    }
    
    func add(title: String, authorId: Int64)
    {
        do{
            let insert = booksTable.insert(self.title <- title, self.authorId <- authorId)
            try db.run(insert)
            print("Book added: \(title) \(authorId)")
        }catch{
            print("Insert book failed. Error: \(error)")
        }
    }
    
    func getByAuthor(authorId: Int64) -> [Book]
    {
        var books: [Book] = []
        
        do{
            let query = booksTable.filter(self.authorId == authorId)
            for row in try db.prepare(query){
                books.append(Book(id: row[id], title: row[title], authorId: row[self.authorId]))
            }
        }catch{
            print("Fetch books failed. Error: \(error)")
        }
        
        return books
    }
    
    func update(id bookId: Int64, newTitle: String)
    {
        let book = booksTable.filter(id == bookId)
        do{
            try db.run(book.update(title <- newTitle))
            print("Book updated: \(newTitle)")
        }catch{
            print("Update book failed. Error: \(error)")
        }
    }
    
    func delete(id bookId: Int64)
    {
        let book = booksTable.filter(id == bookId)
        
        do{
            try db.run(book.delete())
            print("Book deleted successfully")
        }catch{
            print("Delete book failed. Error: \(error)")
        }
    }
}
