//
//  BookViewModel.swift
//  iTrackBook
//
//  Created by Guren Icim on 3.06.2024.
//

import Foundation
import Combine

class BookViewModel: ObservableObject {
    @Published var books: [Book] = [] {
        didSet {
            UserDefaults.standard.saveBooks(books)
        }
    }
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadBooks()
    }
    
    func searchBooks(query: String) {
        let urlString = "https://openlibrary.org/search.json?title=\(query)&limit=10"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                guard let response = json?["docs"] as? NSArray else { return }
                var fetchedBooks: [Book] = []
                for doc in response {
                    if let docx = doc as? [String : Any] {
                        guard let authName = docx["author_name"] as? [String] else {return}
                        guard let title = docx["title"] as? String else {return}
                        guard let id = docx["key"] as? String else {return}
                        let book = Book(id: id, title: title, authorName: authName)
                        fetchedBooks.append(book)
                    }
                }
                DispatchQueue.main.async {
                    self.books = fetchedBooks
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    private func loadBooks() {
        books = UserDefaults.standard.loadBooks()
    }
}


