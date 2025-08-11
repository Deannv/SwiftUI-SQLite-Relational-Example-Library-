//
//  Book.swift
//  MyLibraryApp
//
//  Created by Kemas Deanova on 11/08/25.
//

import Foundation

struct Book: Identifiable, Hashable
{
    var id: Int64
    var title: String
    var authorId: Int64
}
