//
//  MovieDetailViewModel.swift
//  InvioChallenge
//
//  Created by Mehmet Ali Kılıçlı on 24.11.2022.
//

import Foundation

protocol MovieDetailViewModel: BaseViewModel {
    /// ViewModel ' den viewController'a event tetikler
    var stateClosure: ((Result<MovieDetailViewModelImpl.ViewInteractivity, Error>) -> ())? { set get }
    
    func addFavorites(imdbID : String)
    
}


final class MovieDetailViewModelImpl: MovieDetailViewModel {
    func addFavorites(imdbID : String) {
   
    }
    
    var stateClosure: ((Result<ViewInteractivity, Error>) -> ())?
    
    func start() {
        self.stateClosure?(.success(.updateMovieDetail))
    }
}

extension MovieDetailViewModelImpl {
    enum ViewInteractivity {
        case updateMovieDetail
    }
}
