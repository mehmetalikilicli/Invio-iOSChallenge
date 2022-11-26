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
    var min : String
    var year : String
    var language : String
    var ratings: [Rating]
    var plot : String
    var director: String
    var writer : String
    var actors : String
    var country : String
    var boxOffice : String
    
    enum CodingKeys: String, CodingKey {
        case min = "Runtime"
        case year = "Year"
        case language = "Language"
        case ratings = "Ratings"
        case plot = "Plot"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case country = "Country"
        case boxOffice = "BoxOffice"
    }
}
