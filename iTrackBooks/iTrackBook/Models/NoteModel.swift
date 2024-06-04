//
//  NoteModel.swift
//  iTrackBook
//
//  Created by Guren Icim on 3.06.2024.
//

import Foundation

struct Note: Codable {
    let bookId: String
    let pageNumber: Int
    let noteText: String
}
