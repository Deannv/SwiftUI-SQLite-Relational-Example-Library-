//
//  Main.swift
//  MyLibraryApp
//
//  Created by Kemas Deanova on 11/08/25.
//

import SwiftUI

struct Main: View {
    private let authorController = AuthorController()
    private let bookController = BookController()
    
    @State private var authors: [Author] = []
    @State private var books: [Book] = []
    @State private var selectedAuthorId: Int64?
    
    var body: some View {
        VStack
        {
            Button("Add Author") {
                authorController.add(name: "Author \(Int.random(in: 1...100))")
                refreshAuthors()
            }
            
            List(authors) { author in
                VStack(alignment: .leading)
                {
                    Text(author.name).bold()
                    HStack
                    {
                        Button("Show Books"){
                            selectedAuthorId = author.id
                            books = bookController.getByAuthor(authorId: author.id)
                        }
                        
                        Button("Add Book"){
                            bookController.add(title: "Book \(Int.random(in: 1...100))", authorId: author.id)
                            books = bookController.getByAuthor(authorId: author.id)
                        }
                    }
                }
            }
            
            if let selectedAuthorId {
                Text("Books for author \(selectedAuthorId)")
                    .font(.headline)
                List(books) {
                    book in
                    Text(book.title)
                }
            }
        }
        .onAppear{
            refreshAuthors()
        }
    }
    
    func refreshAuthors()
    {
        authors = authorController.getAll()
    }
}

#Preview {
    Main()
}
