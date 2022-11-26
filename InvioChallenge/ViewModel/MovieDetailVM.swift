//
//  MovieDetailVM.swift
//  InvioChallenge
//
//  Created by Mehmet Ali Kılıçlı on 24.11.2022.
//

import Foundation

struct MovieDetailVM {
    
    let movie : MovieDetail
    
    var min : String {
        return movie.min ?? "123 min"
    }
    var year : String {
        return movie.year ?? "2021"
    }
    var language : String {
        return movie.language ?? "English"
    }
    var ratings : [Rating] {
        return movie.ratings
    }
    var plot : String {
        return movie.plot ?? "Lorem ipsum dolor sit amet"
    }
    var director : String {
        return movie.director ?? "Lorem ipsum"
    }
    var writer : String {
        return movie.writer ?? "Lorem ipsum"
    }
    var actors : String {
        return movie.actors ?? "Lorem ipsum"
    }
    var country : String {
        return movie.country ?? "Lorem ipsum"
    }
    var boxOffice : String {
        return movie.boxOffice ?? "Lorem ipsum"
    }
    
    
}
