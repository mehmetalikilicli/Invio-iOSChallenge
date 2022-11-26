//
//  MovieDetailViewModel.swift
//  InvioChallenge
//
//  Created by Mehmet Ali Kılıçlı on 24.11.2022.
//

import Foundation

protocol MovieDetailViewModel: BaseViewModel {
    /// ViewModel ' den viewController'a event tetikler
    var stateClosure: ((Result<SplashViewModelImpl.ViewInteractivity, Error>) -> ())? { set get }
    
    func addFavorites(imdbID : String, completion: @escaping (Movie) -> Void)
}


final class MovieDetailViewModelImpl: MovieDetailViewModel {
    
    var movie : MovieDetailVM?
    
    func addFavorites(imdbID : String, completion: @escaping (Movie) -> Void) {
        
    }
    var stateClosure: ((Result<SplashViewModelImpl.ViewInteractivity, Error>) -> ())?
    
    
    func start() {
        
    }
    
}

extension MovieDetailViewModelImpl {
    enum ViewInteractivity {
        case appStart
    }
}
