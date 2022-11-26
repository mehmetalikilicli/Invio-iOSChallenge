//
//  NetworkManager.swift
//  InvioChallenge
//
//  Created by Mehmet Ali Kılıçlı on 22.11.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func getMoviesByText(searchText: String, completion: @escaping ([Movie]?) -> Void) {
        
        let urlString = "\(Urls.baseUrl)\(Urls.searchUrl)\(searchText)\(Urls.apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            let answer = try? JSONDecoder().decode(Search.self, from: data)
            //print(moviesEnvelope?.movies!)
            answer == nil ? completion(nil) : completion(answer?.movies)
        }.resume()
    }
    
    func getMovieOnTapped(imdbID : String, completion: @escaping (MovieDetail?) -> Void) {
        
        let urlString = "\(Urls.baseUrl)\(Urls.imdbId)\(imdbID)\(Urls.apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            let answer = try? JSONDecoder().decode(MovieDetail.self, from: data)
            
            answer == nil ? completion(nil) : completion(answer)
            //print(answer)
        }.resume()
    }
}
