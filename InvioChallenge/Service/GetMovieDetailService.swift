//
//  GetMovieDetailService.swift
//  InvioChallenge
//
//  Created by Mehmet Ali Kılıçlı on 29.11.2022.
//

import Foundation


class GetMovieDetailService {
    
    static let shared = GetMovieDetailService()
    private init() {}
    
    /// imdbID'ye göre movie detayı döner
    /// Parameter imdbID : movie imdbID
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
