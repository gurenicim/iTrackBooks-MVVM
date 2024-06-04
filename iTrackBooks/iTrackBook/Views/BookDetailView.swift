//
//  BookDetailView.swift
//  iTrackBook
//
//  Created by Guren Icim on 3.06.2024.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book
        @State private var notes: [Note] = []
        @State private var newNoteText: String = ""
        @State private var newNotePageNumber: Int = 0
        
        var body: some View {
            VStack {
                Text(book.title)
                    .font(.largeTitle)
                    .padding()
                
                List {
                    ForEach(notes, id: \.pageNumber) { note in
                        VStack(alignment: .leading) {
                            Text("Page \(note.pageNumber)")
                                .font(.headline)
                            Text(note.noteText)
                        }
                    }
                }
                
                HStack {
                    TextField("Page number", value: $newNotePageNumber, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Note", text: $newNoteText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add Note") {
                        let newNote = Note(bookId: book.id, pageNumber: newNotePageNumber, noteText: newNoteText)
                        notes.append(newNote)
                        newNoteText = ""
                        newNotePageNumber = 0
                    }
                }
                .padding()
            }
            .navigationTitle(book.title)
        }
}


