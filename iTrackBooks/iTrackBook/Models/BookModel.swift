//
//  BookModel.swift
//  iTrackBook
//
//  Created by Guren Icim on 3.06.2024.
//

import Foundation

struct Book: Codable {
    let id: String
    let title: String
    let authorName: [String]
}
