//
//  MovieViewModel.swift
//  InvioChallenge
//
//  Created by Mehmet Ali Kılıçlı on 23.11.2022.
//

import Foundation

struct MovieVM {
    
    let movie : Movie
    
    var id : String {
        return movie.id
    }
    var title : String {
        return movie.title
    }
    var year : String {
        return movie.year
    }
    var type : String {
        return movie.type 
    }
    var poster : String {
        return movie.poster ?? ""
    }
    
}
