//
//  DatabaseManager.swift
//  MyLibraryApp
//
//  Created by Kemas Deanova on 11/08/25.
//

import Foundation
import SQLite

class DatabaseManager {
    static let shared = DatabaseManager()
    
    public var connection: SQLite.Connection?
    
    private let authorsTable = Table("authors")
    private let booksTable = Table("books")
    
    private let id = Expression<Int64>("id")
    private let name = Expression<String>("name")
    private let authorId = Expression<Int64>("authorId")
    private let title = Expression<String>("title")
    
    private init() {
        do{
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            connection = try Connection("\(path)/db.sqlite3")
//            createTables()
        }catch{
            connection = nil
            print("Unable to open database. Error: \(error)")
        }
    }
    
//    private func createTables()
//    {
//        guard let db = connection else {return}
//        
//        do{
//            try db.run(authorsTable.create(ifNotExists: true){
//                table in
//                table.column(id, primaryKey: .autoincrement)
//                table.column(name)
//            })
//            
//            try db.run(booksTable.create(ifNotExists: true){
//                table in
//                table.column(id, primaryKey: .autoincrement)
//                table.column(title)
//                
//                table.column(authorId)
//                table.foreignKey(authorId, references: authorsTable, id, delete: .cascade)
//            })
//        }catch{
//            print("Error creating the table. Error: \(error)")
//        }
//        
//    }
}
