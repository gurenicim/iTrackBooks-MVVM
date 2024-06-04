//
//  BookListView.swift
//  iTrackBook
//
//  Created by Guren Icim on 3.06.2024.
//

import SwiftUI

struct BookListView: View {
    @ObservedObject var viewModel = BookViewModel()
        
        @State private var searchQuery: String = ""
        
        var body: some View {
            NavigationView {
                VStack {
                    TextField("Search books", text: $searchQuery, onCommit: {
                        viewModel.searchBooks(query: searchQuery)
                    })
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    List(viewModel.books, id: \.id) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            HStack {
                                Text(book.title).font(.largeTitle.bold())
                                Spacer()
                                Text(book.authorName.first ?? "No Author")
                            }
                        }
                    }
                }
                .navigationTitle("Book Tracker")
            }
        }
}

