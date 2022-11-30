//
//  MovieDetail.swift
//  InvioChallenge
//
//  Created by Mehmet Ali Kılıçlı on 24.11.2022.
//

import Foundation

struct MovieDetailResponse : Codable {
    var items : [MovieDetail]
}

struct MovieDetail : Codable {
    var title :String
    var min : String
    var year : String
    var language : String
    var ratings: [Rating]
    var plot : String
    var director: String
    var writer : String
    var actors : String
    var country : String
    var poster : String
    var id : String
    var boxOffice : String
    
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case min = "Runtime"
        case year = "Year"
        case language = "Language"
        case ratings = "Ratings"
        case plot = "Plot"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case country = "Country"
        case poster = "Poster"
        case id = "imdbID"
        case boxOffice = "BoxOffice"
    }
}

struct Rating : Codable, Equatable {
    var source : String?
    var value : String?
    
    enum CodingKeys : String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

