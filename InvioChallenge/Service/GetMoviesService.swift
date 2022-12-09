//
//  NetworkManager.swift
//  InvioChallenge
//
//  Created by Mehmet Ali Kılıçlı on 22.11.2022.
//

import Foundation

class GetMoviesService {
    
    static let shared = GetMoviesService()
    private init() {}
    
    /// Aranan kelimeye göre movie listesi döner
    /// Parameter searchText : searchField'da aranan kelime
    /// Parameter nextPage(Optional) : Default olarak 1, movieler ilk çekildiğinde ilk 10 movieyi çeker,
    /// lazy load'da sayfa sayısını parametre olarak alır ve o sayfadaki movieleri döner.
    func getMoviesByText(searchText: String, nextPage : Int = 1, completion: @escaping (Search?) -> Void) {
        
        let urlString = "\(Urls.baseUrl)\(Urls.searchUrl)\(searchText)\(Urls.apiKey)\(Urls.page)\(nextPage)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            let answer = try? JSONDecoder().decode(Search.self, from: data)
            answer == nil ? completion(nil) : completion(answer)
        }.resume()
    }
    
}
